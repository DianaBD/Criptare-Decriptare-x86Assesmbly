build: tema2

tema2: tema2.asm xor_strings.asm break_substitution.asm
	nasm -f elf32 -o tema2.o $<
	nasm -f elf32 -o xor_strings.o xor_strings.asm
	nasm -f elf32 -o rolling_xor.o rolling_xor.asm
	nasm -f elf32 -o xor_hex_strings.o xor_hex_strings.asm
	nasm -f elf32 -o base32decode.o base32decode.asm
	nasm -f elf32 -o bruteforce_singlebyte_xor.o bruteforce_singlebyte_xor.asm
	nasm -f elf32 -o break_substitution.o break_substitution.asm
	gcc -m32 -o $@ tema2.o xor_strings.o rolling_xor.o bruteforce_singlebyte_xor.o xor_hex_strings.o base32decode.o break_substitution.o

clean:
	rm -f tema2 xor_strings.o rolling_xor.o xor_hex_strings.o base32decode.o bruteforce_singlebyte_xor.o break_substitution.o tema2.o 
