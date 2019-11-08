rm -rf cmake-build
cmake -H. -B"cmake-build" -G "Unix Makefiles"
cmake --build "cmake-build" --target BlinkyExample
