# MIT License

# Copyright (c) 2019 Polidea

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Append current directory to CMAKE_MODULE_PATH for making device specific cmake modules visible
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Target definition
set(CMAKE_SYSTEM_NAME  Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

# Set toolchain paths
set(TOOLCHAIN arm-none-eabi)

set(TOOLCHAIN_BIN_DIR "${TOOLCHAIN_PREFIX}/bin")
set(TOOLCHAIN_INC_DIR "${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/include")
set(TOOLCHAIN_LIB_DIR "${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/lib")

# Set system depended extensions
if(WIN32)
  set(TOOLCHAIN_EXT ".exe" )
else()
  set(TOOLCHAIN_EXT "" )
endif()

# Perform compiler test with static library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set compiler linker flags
set(OBJECT_GEN_FLAGS "-mabi=aapcs -mthumb")
set(OBJECT_CXX_GEN_GLAGS "${OBJECT_GEN_FLAGS} -fdata-sections -ffunction-sections -fno-builtin -fno-strict-aliasing -fshort-enums -Wall")

set(CMAKE_C_FLAGS   "${OBJECT_CXX_GEN_GLAGS} -std=c99 " CACHE INTERNAL "C Compiler options")
set(CMAKE_CXX_FLAGS "${OBJECT_CXX_GEN_GLAGS} -fno-exceptions -fno-rtti -Wno-register -std=c++17 " CACHE INTERNAL "C++ Compiler options")
set(CMAKE_ASM_FLAGS "${OBJECT_GEN_FLAGS} -g3" CACHE INTERNAL "ASM Compiler options")

set(CMAKE_EXE_LINKER_FLAGS "${OBJECT_GEN_FLAGS} -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs -lc -lnosys -lm" CACHE INTERNAL "Linker options")

# Debug/Release configuration
set(CMAKE_C_FLAGS_DEBUG "-Og -g3 -DDEBUG" CACHE INTERNAL "C Compiler options for debug build type")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g3 -DDEBUG" CACHE INTERNAL "C++ Compiler options for debug build type")
set(CMAKE_ASM_FLAGS_DEBUG "" CACHE INTERNAL "ASM Compiler options for debug build type")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE INTERNAL "Linker options for debug build type")

set(CMAKE_C_FLAGS_RELEASE "-O2 -flto" CACHE INTERNAL "C Compiler options for release build type")
set(CMAKE_CXX_FLAGS_RELEASE "-O2 -flto" CACHE INTERNAL "C++ Compiler options for release build type")
set(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "ASM Compiler options for release build type")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-flto" CACHE INTERNAL "Linker options for release build type")

set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g3 -flto" CACHE INTERNAL "C Compiler options for release + dbg info build type")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g3 -flto" CACHE INTERNAL "C++ Compiler options for release + dbg info build type")
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "" CACHE INTERNAL "ASM Compiler options for release + dbg info build type")
set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "-flto" CACHE INTERNAL "Linker options for release + dbg info build type")

set(CMAKE_C_FLAGS_MINSIZEREL "-Os -flto" CACHE INTERNAL "C Compiler options for minsize release build type")
set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -flto" CACHE INTERNAL "C++ Compiler options for minsize release build type")
set(CMAKE_ASM_FLAGS_MINSIZEREL "" CACHE INTERNAL "ASM Compiler options for minsize release build type")
set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "-flto" CACHE INTERNAL "Linker options for minsize release build type")

# Setup compilers
set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-gcc${TOOLCHAIN_EXT} CACHE INTERNAL "C Compiler")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-g++${TOOLCHAIN_EXT} CACHE INTERNAL "C++ Compiler")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-gcc${TOOLCHAIN_EXT} CACHE INTERNAL "ASM Compiler")
set(CMAKE_OBJCOPY_BIN ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-objcopy${TOOLCHAIN_EXT} CACHE INTERNAL "objcopy executable")
set(CMAKE_SIZE_BIN ${TOOLCHAIN_BIN_DIR}/${TOOLCHAIN}-size${TOOLCHAIN_EXT} CACHE INTERNAL "size executable")

set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PREFIX}/${${TOOLCHAIN}} ${CMAKE_PREFIX_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
