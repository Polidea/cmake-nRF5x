#!/bin/bash

source "${BASH_SOURCE%/*}/common/build_example.sh"

# Ignored list of examples separated with semicolon.
build_ignore_config_list="pca10100_16.0.0"

function ns_to_ms() {
    if [[ ${#1} -lt 7 ]]; then
        echo 0
    fi

    echo ${1::-6}
}

function build_all_configs() {
    local example=$1
    local sdk_version=$2
    local toolchain=$3
    local config_dir=$4
    local build_dir=$5
    local log_level=$6
    local build_summary_file=$7
    local board_filter=$8
    local sd_variant_filter=$9
    local flags="${10}"

    if [[ ! -d $config_dir ]]; then
        echo "\"$config_dir\" is not a valid configuration directory"
        return 1
    fi

    # For each board
    for board_dir in `ls -d $config_dir/pca*`; do
        board=`basename $board_dir`

        # Skip board configuration that does not match the filter
        if [[ -n "$board_filter" ]] && [[ "$board" != "$board_filter" ]]; then
            continue
        fi

        # Identify SoftDevice variants (including 'blank' configs) available for the specified board
        supported_sd_variant_dirs=($(ls -d $board_dir/s* 2> /dev/null))
        supported_sd_variant_dirs+=($(ls -d $board_dir/blank 2> /dev/null))

        if [[ "${#supported_sd_variant_dirs[@]}" -eq 0 ]]; then
            echo "No configurations found for the '$example' for the '$board' board (config. dir.: $config_dir). Build skipped."
            continue
        fi

        # For each SDK variant
        for sd_variant_dir in ${supported_sd_variant_dirs[@]}; do
            sd_variant=`basename $sd_variant_dir`

            # Skip SD variant that does not match the filter
            if [[ -n "$sd_variant_filter" ]] && [[ "$sd_variant" != "$sd_variant_filter" ]]; then
                continue
            fi

            # Check if combination is ignored 
            if [[ $build_ignore_config_list =~ "${board}_${sdk_version}" ]]; then
                continue
            fi
            
            local start_ts=`date +%s%N`

            local build_status
            build_example "$example" "$sdk_version" "$board" "$sd_variant" "$toolchain" "$config_dir" "$build_dir" "$log_level" "${flags[*]}"
            [[ $? -eq 0 ]] && build_status="success" || build_status="failure" 

            local end_ts=`date +%s%N`
            local build_time_ms=$(ns_to_ms `expr $end_ts - $start_ts`)
            
            if [[ -f $build_summary_file ]]; then
                printf "$BUILD_SUMMARY_ENTRY_FORMAT" "$example" "$board" "$sd_variant" "$sdk_version" "$build_time_ms ms" "$build_status" >> "$build_summary_file"
            fi
        done
    done

    return 0
}

function print_help() {
    echo "
    Usage:
    --------------------------------------------------------------------------------

    [Optional]
        --example=<name>            Part of the name of the example(s) to be build. Passed
                                    to grep to filter the examples.

        --board=<board>             Complete name of the board to build examples for
                                    eg. pca10040, pca10056.

        --sd_variant=<variant>      Complete name of the SoftDevice variant use when building
                                    examples e.g. s132, s140.

        --sdk_versions={<version>}  nRF5 SDK version used for building examples, multiple
                                    SDK versions can be passed, e.g. \"15.3.0 16.0.0\".
                                    By default, the examples will be built for all SDK
                                    versions downloaded during the prepare step.

        --log_level=<log_level>     CMake log level. Will be passed as '--log-level' option
                                    when invoking CMake. Available log levels: TRACE, DEBUG,
                                    VERBOSE, STATUS, NOTICE, WARNING, ERROR.

        --clean                     Invoke build system 'Clean' command before building
                                    each example.

    "
    exit 0
}

example_filter=""
board_filter=""
sd_variant_filter=""
sdk_version_list=""
log_level="NOTICE"
flags=()

while getopts ":h-:" opt; do
    case $opt in
        -) {
            # Handle long options ("--option=<arg>")
            case $OPTARG in
                example=*)
                    example_filter=${OPTARG#*=} ;;
                board=*)
                    board_filter=${OPTARG#*=} ;;
                sd_variant=*)
                    sd_variant_filter=${OPTARG#*=} ;;
                sdk_versions=*)
                    sdk_version_list=${OPTARG#*=} ;;
                log_level=*) {
                    log_level=${OPTARG#*=} 
                    if [[ ! $log_level =~ $CMAKE_LOG_LEVEL_REGEXP ]]; then
                        echo "Invalid log level \"$log_level\" (available log levels: TRACE, DEBUG, VERBOSE, STATUS, NOTICE, WARNING, ERROR)"
                        exit 1
                    fi
                };;
                clean)
                    flags+=('clean') ;;
                help)
                    print_help ;;
                *) {
                    if [[ $OPTERR -eq 1 ]]; then
                        echo "Unknown option \"--$OPTARG\" or missing argument (use \"--option=<arg>\" syntax), use \"--help\""
                        exit 1
                    fi
                };;
            esac
        };;
        h) {
            print_help
        };;
        \?) {
            unknown_optind=$(($OPTIND - 1))
            unknown_opt=${!unknown_optind}
            echo "Uknown option \"$unknown_opt\""
            exit 1
        };;
    esac
done


sdk_versions=($sdk_version_list)

if [[ ${#sdk_versions[@]} -gt 0 ]]; then
    # Build examples for the passed SDK versions
    for sdk_ver in ${sdk_versions[@]}; do
        # Check if passed SDK versions are correct and present
        if [[ ! -d "$SDKS_DIR/$sdk_ver" ]]; then
            echo "nRF5 SDK $sdk_ver not found in $SDKS_DIR"
            exit 1
        fi
    done
else
    # With no arguments passed, build examples for all SDK version present
    for sdk_ver in `ls -d $SDKS_DIR/*/`; do
        sdk_versions+=( `basename $sdk_ver` )
    done
fi

if [[ ${#sdk_versions[@]} -eq 0 ]]; then
    echo "No nRF5 SDK found in $SDKS_DIR. Build terminated."
    exit 1
fi

echo "Building examples for SDK versions: ${sdk_versions[@]}"

# Collect relative paths to the examples.
example_local_dirs=()
# Filter example dirs with grep if '--example' option was passed
[[ -n $example_filter ]] && example_filter="grep $example_filter" || example_filter="cat"
pushd "$EXAMPLES_DIR" > /dev/null
    for example in `eval 'find . -name "CMakeLists.txt" | $example_filter'`; do
        example_dir=`dirname $example`
        # Strip the '.' prefix (current directory) from the example directory
        example_local_dirs+=(${example_dir#./})
    done
popd > /dev/null

# Init temp. file to contain build summary
build_summary_file="$BUILD_DIR/.tmp/build_summary.tmp"
mkdir -p `dirname $build_summary_file`

# Print build summary header

printf "BUILD SUMMARY\n\n" > $build_summary_file
printf "$BUILD_SUMMARY_ENTRY_FORMAT" "example" "board" "sd_variant" "sdk_version" "elapsed" "status" >> "$build_summary_file"

for i in `seq 1 128`; do
    printf "-" >> "$build_summary_file"
done

printf "\n" >> "$build_summary_file"

# Applying examples to included SDKs
for sdk_ver in "${sdk_versions[@]}"; do
    # For each SDK, try to apply examples
    for example in "${example_local_dirs[@]}"; do
        # Build all custom configs in the local example directory
        if [[ -d "$EXAMPLES_DIR/$example/config" ]]; then
            build_all_configs "$example" "$sdk_ver" "gcc" "$EXAMPLES_DIR/$example/config" "$BUILD_DIR/local" "$log_level" "$build_summary_file" "$board_filter" "$sd_variant_filter" "${flags[*]}"
        fi

        # Build all configs in the SDK example directory
        build_all_configs "$example" "$sdk_ver" "gcc" "$SDKS_DIR/$sdk_ver/examples/$example" "$BUILD_DIR" "$log_level" "$build_summary_file" "$board_filter" "$sd_variant_filter" "${flags[*]}"
    done
done

echo ""
cat "$build_summary_file"
