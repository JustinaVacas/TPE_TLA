#!/bin/bash

# check if the number of arguments are correct
if [ "$#" -ne 2 ]; then
    echo "Must specify the source file and destination file as parameters"
    exit 1
fi

# check if the source file exists
FILE_SOURCE="$1"
if [ ! ${FILE_SOURCE: -4} == ".braille" ]; then
    echo "The source file must have .braille extension"
    exit 1
fi

if [ ! -e "${FILE_SOURCE}" ]; then
    echo "Source file ${FILE_SOURCE} doesn't exists"
    exit 1
fi

if [ -e "${FILE_SOURCE}.c" ]; then
    rm "${FILE_SOURCE}.c"
fi
touch "${FILE_SOURCE}.c"

FILE_C_SOURCE_REAL_PATH=$(pwd)/"${FILE_SOURCE}.c"
FILE_SOURCE_REAL_PATH=$(pwd)/${FILE_SOURCE}

# generate the code
cd compiler
./compiler < ${FILE_SOURCE_REAL_PATH} > ${FILE_C_SOURCE_REAL_PATH}
if [[ $? -ne 0 ]]; then
    exit 1
fi
cd ..

FILE_DESTINATION="$2"
FILE_DESTINATION_REAL_PATH=$(pwd)/${FILE_DESTINATION}
# compile gcc
gcc ${FILE_C_SOURCE_REAL_PATH} -o ${FILE_DESTINATION_REAL_PATH}