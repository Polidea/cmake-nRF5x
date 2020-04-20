#!/bin/bash

# This script collects data from the specified SDK(s) in form of a file
# with following schema:
# FILE:
# filepath
# SOURCES:
# source1
# source2
# ...
# INCLUDES:
# include1
# ...
# ASM:
# flag1
# ...
# C:
# flag1
# ...
# LINKER:
# flag1
# ...

source "${BASH_SOURCE%/*}/common/consts.sh"

sdks=($@)
for sdk in ${sdks[@]}; do
    FILES=$(
        find "${SDKS_DIR}/${sdk}" | 
        rg "examples/.*/armgcc/Makefile"
    )

    for file in $FILES; do
        source_files=$(
            cat $file | 
            rg --multiline "SRC_FILES(.*\\\\\s*\n)+" |
            rg "\s*(\\$\\(SDK_ROOT\\)/)" -r "" |
            rg "\\\\" -r "" |
            rg "\s+" -r "" |
            sort | 
            uniq
        )

        include_files=$(
            cat $file | 
            rg --multiline "INC_FOLDERS(.*\\\\\s*\n)+" |
            rg "\s*(\\$\\(SDK_ROOT\\)/)" -r "" |
            rg "\\\\" -r "" |
            rg "\s+" -r "" |
            sort | 
            uniq
        )

        cflags=$(
            cat $file | 
            rg --multiline "CFLAGS\s*\+= \-" |
            rg ".*CFLAGS\s*\+=" -r "" |
            sed $'s/ /\\\n/g' |
            sed $'s/,/\\\n/g' |
            sort |
            uniq |
            sed '/^$/d'
        )

        asmflags=$(
            cat $file | 
            rg --multiline "ASMFLAGS\s*\+= \-" |
            rg ".*ASMFLAGS\s*\+=" -r "" |
            sed $'s/ /\\\n/g' |
            sed $'s/,/\\\n/g' |
            sort |
            uniq |
            sed '/^$/d'
        )

        ldflags=$(
            cat $file | 
            rg --multiline "LDFLAGS\s*\+= \-" |
            rg ".*LDFLAGS\s*\+=" -r "" |
            sed $'s/ /\\\n/g' |
            sed $'s/,/\\\n/g' |
            sort |
            uniq |
            sed '/^$/d'
        )

        echo "FILE:"
        echo "$file"
        echo "SOURCES:"
        echo "$source_files"
        echo "INCLUDES:"
        echo "$include_files"
        echo "C:"
        echo "$cflags"
        echo "ASM:"
        echo "$asmflags"
        echo "LINKER:"
        echo "$ldflags"
    done
done
