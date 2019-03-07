GLOBAL xor_hex_strings
extern strlen

letter_to_dec:
    push ebp
    mov ebp,esp
    mov eax,[ebp+8]
    
    cmp al,97
    jb almost_done_al
    sub al,39
    almost_done_al:
    cmp ah,97
    jb almost_done_ah
    sub ah,39
    almost_done_ah:
    
    sub al,'0'
    sub ah,'0'
    
    leave
    ret
    
convert:
    push ebp
    mov ebp,esp
    xor eax,eax
    mov ax,word[ebp+8]
   
    push eax
    call letter_to_dec
    
    xor ebx,ebx
    add_16_al_times:
        add ebx,16
        dec al
        cmp al,0
        jnz add_16_al_times
    
    shr eax,8 ;move ah in al
    add ebx,eax
    add esp,4
    leave
    ret
           
xor_hex_strings:
        push ebp
        mov ebp,esp
        ;[ebp + 12] adresa inceput sir4
        ;[ebp + 8] adresa inceput sir5
        
        ;pune in ecx lungimea sirurilor
        mov edx,[ebp + 12] ;adresa inceput sir4
        push edx
        call strlen
        add esp,4
        mov ecx,eax
        
        mov edx,[ebp + 12] ;adresa inceput sir4
        mov ebx,[ebp + 8] ;adresa inceput sir5
       
        mov eax,[ebp + 12]
        for3:
            
            push ecx
            push eax
            
            push ebx
            
            xor eax,eax
            mov ax,word[edx]
            ;PRINT_HEX 2,ax
            ;NEWLINE
   
            push eax
            call convert
            add esp,4
            mov byte[edx],bl

            pop ebx ;adresa str2
            xor eax,eax
            mov ax,word[ebx]

            push ebx
            push eax
            call convert
            add esp,4
            
            xor ecx,ecx
            mov cl,byte[edx]
            xor cl,bl
            mov byte[edx],cl
            pop ebx
            
            pop eax
         
            mov byte[eax],cl ; in-place
           
            inc eax
            add edx,2
            add ebx,2
            pop ecx
            sub ecx,2
            cmp ecx,0
            jnz for3
        
        mov byte[eax],0
        mov edx,[ebp + 12]
       
        leave
        ret
