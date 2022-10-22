cd $2
clang-13 -emit-llvm -S -c $1.c -o $1.ll
llvm2graph < $1.ll > $1.pbtxt
graph2json < $1.pbtxt > $1.json



