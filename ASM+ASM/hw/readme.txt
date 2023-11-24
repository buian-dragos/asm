nasm -fobj read.asm
nasm -fobj max.asm
nasm -fobj write.asm
nasm -fobj main.asm

alink main.obj read.obj max.obj write.obj -oPE -subsys console -entry start

main.exe