
GLOBAL strlen

extern puts
extern printf

extern xor_strings
extern rolling_xor
extern xor_hex_strings
extern base32decode
extern bruteforce_singlebyte_xor
extern break_substitution

section .data
;filename: db "/home/diana/Anul II/IOCLA/Tema2/iocla-tema2-resurse/input.dat",0
filename: db "input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0

section .text
global main

;functie care pune in eax lungimea sirului primit ca parametru
strlen:
    push ebp
    mov ebp,esp
    
    mov ebx,dword[ebp+8]
    cld
    mov edi,dword[ebp+8]
    xor eax,eax
    mov ecx,2000
    repne scasb
    sub edi,ebx
    mov eax,edi
    dec eax 
    
    leave
    ret

;functie care pune in ecx adresa sirului nr edx
next_str_address:
    push ebp
    mov ebp,esp
    mov ecx,[ebp + 8]
    mov edx,[ebp + 12]
    xor ebx, ebx
    
    for:
        mov edi, ecx
        xor eax,eax
        repne scasb
        lea ecx, [ebp + 8]
        mov ecx,edi
        dec edx
        cmp edx,0
        jnz for    
    leave
    ret
    
main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    sub esp, 2300
    
    ; fd = open("./input.dat", O_RDONLY);
    mov eax, 5
    mov ebx, filename
    xor ecx, ecx
    xor edx, edx
    int 0x80
    
	; read(fd, ebp-2300, inputlen);
	mov ebx, eax
	mov eax, 3
	lea ecx, [ebp-2300]
	mov edx, [inputlen]
	int 0x80

	; close(fd);
	mov eax, 6
	int 0x80

	; all input.dat contents are now in ecx (address on stack)

	; TASK 1: Simple XOR between two byte streams
	; TODO: compute addresses on stack for str1 and str2
        ; TODO: XOR them byte by byte
        ;push addr_str2
	;push addr_str1
	;call xor_strings
	;add esp, 8
        ; Print the first resulting string
	;push addr_str1
	;call puts
	;add esp, 4

        ;pun adresa str1 pe stiva
        lea ecx, [ebp-2300]
        push ecx
        
        ;determin adresa str2
        mov eax,1
        push eax
        lea ecx, [ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        ;pun adresa str2 pe stiva
        push ecx
     
        call xor_strings
        add esp,8
       
        ;afisez str1 decodificat
        lea ecx,[ebp-2300]
        push ecx
        call puts
        add esp,4
	
        
	; TASK 2: Rolling XOR
	; TODO: compute address on stack for str3
	; TODO: implement and apply rolling_xor function
	;push addr_str3
	;call rolling_xor
	;add esp, 4

	; Print the second resulting string
	;push addr_str3
	;call puts
	;add esp, 4
        
        ;determin adresa str3 de la task2
        mov eax,2
        push eax
        lea ecx, [ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        ;pun pe stiva str3
        push ecx
        ;call strlen 
        ;push eax
        call rolling_xor
        add esp,4
        
        ; rolling xor pune adresa str3 in edx
        push edx
        call puts
        add esp,4
        
	; TASK 3: XORing strings represented as hex strings
	; TODO: compute addresses on stack for strings 4 and 5
	; TODO: implement and apply xor_hex_strings
	;push addr_str5
	;push addr_str4
	;call xor_hex_strings
	;add esp, 8

	; Print the third string
	;push addr_str4
	;call puts
	;add esp, 4
	
        mov eax,3
        push eax
        lea ecx, [ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        push ecx ; str3.1
       
        mov eax,4
        push eax
        lea ecx, [ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        push ecx ; str3.2
       
        call xor_hex_strings
        add esp,8
        
        push edx
        call puts
        add esp,4
        
        
	; TASK 4: decoding a base32-encoded string
	; TODO: compute address on stack for string 6
	; TODO: implement and apply base32decode
	;push addr_str6
	;call base32decode
	;add esp, 4

	; Print the fourth string
	;push addr_str6
	;call puts
	;add esp, 4

        mov eax,6 ;trebuie sa sar peste inca un sir, la task3 am pus un 0 in plus
        push eax    
        lea ecx, [ebp-2300]
        push ecx    ;adresa sir sursa codificat
        call next_str_address
        add esp,4
        push ecx
        
        lea ecx,[ebp-7000] ;adresa sir final
        push ecx
        
        lea ecx, [ebp-3300]
        push ecx    ;adresa sir intermediar
        call base32decode
        push ebx
        call puts
        add esp,16
        
        
	; TASK 5: Find the single-byte key used in a XOR encoding
	; TODO: determine address on stack for string 7
	; TODO: implement and apply bruteforce_singlebyte_xor
	;push key_addr
	;push addr_str7
	;call bruteforce_singlebyte_xor
	;add esp, 8

	; Print the fifth string and the found key value
	;push addr_str7
	;call puts
	;add esp, 4

	;push keyvalue
	;push fmtstr
	;call printf
	;add esp, 8
        
        mov eax,7
        push eax
        lea ecx,[ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        lea eax, [ebp-5000] ;key address
        push eax
        push ecx ; address of string to decode
        call bruteforce_singlebyte_xor
        add esp,8
        
        push ebx
        call puts
        add esp,4
        
        xor ebx,ebx
        mov ebx,[ebp-5000] ; key address
        push ebx
        push fmtstr
        call printf
        
	; TASK 6: Break substitution cipher
	; TODO: determine address on stack for string 8
	; TODO: implement break_substitution
	;push substitution_table_addr
	;push addr_str8
	;call break_substitution
	;add esp, 8

	; Print final solution (after some trial and error)
	;push addr_str8
	;call puts
	;add esp, 4

	; Print substitution table
	;push substitution_table_addr
	;call puts
	;add esp, 4
        
        mov eax,8
        push eax
        lea ecx,[ebp-2300]
        push ecx
        call next_str_address
        add esp,8
        
        ;last string to decode - frate mult a mai durat
        push ecx

        lea ecx,[ebp-7000];table address
        push ecx
        
        call break_substitution
        add esp,8
        
	push ecx
        call puts
        add esp,4
    
        lea ecx,[ebp-7000] ;tabel
        push ecx
        call puts
        add esp,4
        
    xor eax, eax
    leave
    ret
