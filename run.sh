#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <input_file> [run|clean] [DUMP=1|2]"
    exit 1
fi

x="$1"
stripped="${x%.s}"

mkdir -p ./obj ./bin

as -arch arm64 -o "./obj/${stripped}.o" "$x"
ld -o "./bin/$stripped" "./obj/${stripped}.o" \
    -lSystem \
    -syslibroot "$(xcrun -sdk macosx --show-sdk-path)" \
    -e _start \
    -arch arm64

if [[ $2 == "run" ]]; then 
    chmod +x "./bin/$stripped"
    "./bin/$stripped"
elif [[ $2 == "clean" ]]; then 
    rm -f a.out 
    rm -f ./*.o
else
    echo "Nothing to do"
fi

if [[ "$DUMP" == "1" ]]; then 
    echo "Dump"
    objdump -d "./obj/${stripped}.o"
elif [[ "$DUMP" == "2" ]]; then 
    echo " "
    echo "strings:"
    strings "./obj/${stripped}.o"
fi