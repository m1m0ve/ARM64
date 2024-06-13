x=$1
stripped="${x%.s}"

as -arch arm64 -o ./obj/$stripped.o $x
ld -o ./bin/$stripped ./obj/$stripped.o \
	-lSystem \
	-syslibroot `xcrun -sdk macosx --show-sdk-path` \
	-e _start \
	-arch arm64

if [[ $2 == "run" ]]; then 
  ./bin/$stripped

elif  [[ $2 == "clean" ]]; then 
  rm -f a.out 
  rm -f *.o
else
  echo "Nothing to do"
fi


if [[  "$DUMP" == "1" ]]; then 

 echo "Dump"
 objdump -d ./obj/$stripped.o

elif  [[ "$DUMP" == "2" ]]; then 
  echo " "
  echo "strings:"
  strings ./obj/$stripped.o
fi 
