nasm change_alphabet.asm -fwin32 -o change_alphabet.obj

cl main.c /link change_alphabet.obj