GLOBAL base32decode
extern strlen

base32decode:
    push ebp
    mov ebp,esp
    
    mov edx,[ebp + 16]  ;adresa sir sursa
                        ; [ebp +12] e adresa vectorului pt stringul final
    mov ebx,[ebp + 8]   ; adresa sir intermediar
    xor eax,eax
    
    create_binary_message:
     
        xor ecx,ecx
        mov cl,byte[edx]
 
        ;verific daca s-a terminat sirul: "0" in cl
        cmp cl,0
        jz end_string
    
        ;transform simbolul din baza 32 in valoarea numerica aferenta
        inc eax ;contor
        cmp ecx,65
        jb not_letter
        sub ecx,41
        not_letter:
            sub ecx,24
        cmp cl,37
        jnz not_done_yet
        xor cl,cl
        not_done_yet:
        mov byte[ebx],cl
        inc edx
        inc ebx   
    jmp create_binary_message
    
    end_string:
    mov byte[ebx],0 
    
    mov ebx,[ebp + 8]
    push ebx ;primul param, sirde numere in 32 obtinut
    
    ;calculez lungimea sirului final
    ;inmultesc cu 5 si impart la 8
    mov ecx,eax 
    shl ecx,2 
    add ecx,eax
    shr ecx,3
    
    push ecx ;nr de caractere in baza 16
    mov eax,[ebp+12]
    push eax ;adresa unde voi pune sirul transformat inversat
    call delete_stupid_zeros
   
    add esp,12
    leave 
    ret
    
delete_stupid_zeros:
    push ebp
    mov ebp,esp
    
    mov edx,[ebp+16] ;adresa vect de numere
    mov ecx,[ebp+12] ;nr final de octeti
    mov ebx,[ebp+8]  ;unde pun sirul final, inversat
    add ebx,ecx ; scriu de la sfarsit la inceput
    inc ebx
    mov byte[ebx],0
    sub ebx,4
    while:
        push ecx
        
        mov ecx,4
        xor eax,eax
        for_4_times:
            mov al,byte[edx]
            shl al,3
            shl eax,5
            inc edx
            dec ecx
            cmp ecx,0
            jnz for_4_times
             
        mov al,byte[edx]
        shl al,3
        shl eax,4
        inc edx
        mov [ebx],eax
        shl eax,1
        sub ebx,2
        
        mov ecx,3
        for_3_times:
            mov al,byte[edx]
            shl al,3
            shl eax,5
            inc edx
            dec ecx
            cmp ecx,0
            jnz for_3_times
        mov [ebx],eax
        sub ebx,3
       
        pop ecx
        sub ecx,5
        cmp ecx,0
        jnz while
    
    ; sirul se termina cu 0 (din "=")care trebuie sariti
    mov ebx,[ebp+8]
    mov eax,[ebp+12]
    get_start:
        xor ecx,ecx
        inc ebx
        dec eax ; actualizez lungimea - nu mai numar zerourile
        mov cl,byte[ebx]
        cmp ecx,0
        jz get_start
    inc eax ;pt ca am decrementat eax si cand a ajuns la primul caracter
    
    ;push adresa sirului de inversat
    ;push lungimea sirului
    ;call reverse 
    push ebx
    push eax ; lungimea
    call reverse
    ;dupa reverse sirul final se afla in ebx
    add esp,8
    leave
    ret
 
reverse:
    push ebp
    mov ebp, esp
    
    mov ebx,[ebp+12]
    mov edx,[ebp+12]
    mov eax,[ebp+8] ;lungimea
    
    add edx,eax
    mov byte[edx],0
    dec edx
    
    mov ecx, eax
    shr ecx,1
    
    swap:
        push ecx
        
        xor ecx,ecx
        mov cl,byte[ebx]
        mov ch,byte[edx]
        mov byte[ebx],ch
        mov byte[edx],cl
        
        inc ebx
        dec edx
        
        pop ecx
        dec ecx
        cmp ecx,0
        jnz swap
    mov ebx,[ebp+12]
    leave
    ret    
       
 
    