GLOBAL break_substitution

extern puts
extern putchar
break_substitution:
    push ebp
    mov ebp,esp
    
    ;[ebp+12] adresa mesaj codificat
    ;[ebp+8] adresa tabel
    
    ;[ebp-5097] adresa vector aparitii
    ;[ebp-6000] adresa "etaoin..."

    mov edx,[ebp+8]
    xor eax,eax
    mov al,97 ; caracterul 'a'
    lea ecx,[ebp-5097]
    from_a_to_z:
    
        ;adaug al la tabel
        mov byte[edx],al
        push edx
        
        ;adaug al la vectorul de aparitii
        mov byte[ecx+eax],al 
        mov word[ecx+eax+1],0
        
        ;numar aparitiile caracterului al in mesaj
        mov edx,[ebp+12]
        while_string_doesnt_end:
            mov bl,byte[edx]
            cmp bl,0
            jz next_letter ;s-a terminat sirul
            cmp al,bl
            jnz next_byte
                mov bx,word[ecx+eax+1]
                inc bx
                mov word[ecx+eax+1],bx
            next_byte: 
            inc edx
            jmp while_string_doesnt_end
        next_letter:  
        pop edx
        add edx,2 ;adresa pt ur caracter in tabel
        
        add ecx,2; adresa pt urm caracter in vector
         
        inc al ;urm litera din alfabet
        cmp al,122 ; 122 ='z'
        jng from_a_to_z 
    
    lea ecx,[ebp-5000]
    add ecx,78 ;3*26caractere  
    mov al,32 ; caracterul ' '    
    ;adaug al la tabel
        mov byte[edx],al
        push edx 
        ;adaug al la vectorul de aparitii
        mov byte[ecx],al 
        mov word[ecx+1],0
        
        ;numar aparitiile caracterului ' ' in mesaj
        mov edx,[ebp+12]
        while_string_doesnt_end2:
            mov bl,byte[edx]
            cmp bl,0
            jz next_letter2 ;s-a terminat sirul
            cmp al,bl
            jnz next_byte2
                mov bx,word[ecx+1]
                inc bx
                mov word[ecx+1],bx
            next_byte2: 
            inc edx
            jmp while_string_doesnt_end2
        next_letter2:  
        pop edx
        add edx,2 ;adresa pt ur caracter in tabel
        
        add ecx,3; adresa pt urm caracter in vector
        
      
    mov al,46 ; caracterul '.'    
    ;adaug al la tabel
        mov byte[edx],al
        push edx 
        ;adaug al la vectorul de aparitii
        mov byte[ecx],al 
        mov word[ecx+1],0
        
        ;numar aparitiile caracterului '.' in mesaj
        mov edx,[ebp+12]
        while_string_doesnt_end3:
            mov bl,byte[edx]
            cmp bl,0
            jz next_letter3 ;s-a terminat sirul
            cmp al,bl
            jnz next_byte3
                mov bx,word[ecx+1]
                inc bx
                mov word[ecx+1],bx
            next_byte3: 
            inc edx
            jmp while_string_doesnt_end3
        next_letter3:  
        pop edx
        add edx,2 ;adresa pt ur caracter in tabel
        
        add ecx,3; adresa pt urm caracter in vector        
                              
    mov byte[ecx],0
    mov byte[edx],0
    
    ;sortare vector aparitii
    lea edx,[ebp-5000]
    xor ecx,ecx
    xor ebx,ebx
    for_ecx_0_81:
        mov ebx,ecx
        add ebx,3
        for_ebx_ecx_84: 
            mov ax,word[edx+ecx+1]
            push ecx
            mov cx,word[edx+ebx+1]
            cmp ax,cx
            pop ecx
            jnb skip_swap
                push ecx
                ; schimba aparitiile
                mov cx,word[edx+ebx+1]
                mov word[edx+ebx+1],ax
                mov ax,cx
                pop ecx
                mov word[edx+ecx+1],ax
                ; schimba literele
                mov al,byte[edx+ecx]
                mov ah,byte[edx+ebx]
                mov byte[edx+ecx],ah
                mov byte[edx+ebx],al
            skip_swap:
            add ebx,3
            cmp ebx,84
            jnz for_ebx_ecx_84 ;inainte 52
        add ecx,3
        cmp ecx,81
        jnz  for_ecx_0_81

    ;punem "etaoin..." la [ebp-6000]
    lea ecx,[ebp-6000]
    ; dupa ce am rulat toata chestia cu " etaoin..." am schimbat ordinea   
   
    ;mov dword[ecx]," eta"
    ;mov dword[ecx+4],"oins"
   ; mov dword[ecx+8],"hrdl"
   ; mov dword[ecx+12],"ucmf"
   ; mov dword[ecx+16],"wypv"
   ; mov dword[ecx+20],"bgkj"
   ; mov dword[ecx+24],"qxz."
   ; mov byte[ecx+28],0
    
    mov dword[ecx]," eta"
    mov dword[ecx+4],"osin"
    mov dword[ecx+8],"rdhm"
    mov dword[ecx+12],"lcwu"
    mov dword[ecx+16],".fpy"
    mov dword[ecx+20],"gvbk"
    mov dword[ecx+24],"jxzq"
    mov byte[ecx+28],0

    ;[ebp-6000] adresa etaoin
    ;[ebp-5000] adresa vector
 
    mov edx,[ebp+12]  
    while_msg_didnt_end:
        mov bl,byte[edx] ;caracter din mesaj
        cmp bl,0
        jz done_with_that
        push edx
        
        ;cauta pozitia in vect de aparitii
        xor ecx,ecx
        lea eax,[ebp-5000] ;vect apariti
        ;il caut in vect de apatitii
        while_al_not_found:
            push ecx
            mov cl,byte[eax]
            cmp bl,cl
            jz found_it
            add eax,3
            pop ecx
            inc ecx
            jmp while_al_not_found
        found_it:
        pop ecx
        lea eax,[ebp-6000] ;adresa etaoin...
        mov bl,byte[eax+ecx] ;caracterul corespunzator din etaoin..

        pop edx
        
        mov byte[edx],bl ;inlocuieste in mesaj cu litera din etaoin
        inc edx
        jmp while_msg_didnt_end
        
    done_with_that:
    
    ;completam tabelul de mana ca altfel ia o groaza si m-am saturat vreau sa ma culc
   ; mov eax,[ebp+8] ; adresa tabel
   ; mov byte[eax+1],'q'   ;a
   ; mov byte[eax+3],'p'   ;b
   ; mov byte[eax+5],'w'   ;c
   ; mov byte[eax+7],'e'   ;d
   ; mov byte[eax+9],' '   ;e
   ; mov byte[eax+11],'u'  ;f
   ; mov byte[eax+13],'t'  ;g
   ; mov byte[eax+15],'y'  ;h
   ; mov byte[eax+17],'i'  ;i  
   ; mov byte[eax+19],'o'  ;j
   ; mov byte[eax+21],'r'  ;k
   ; mov byte[eax+23],'f'  ;l
   ; mov byte[eax+25],'h'  ;m
   ; mov byte[eax+27],'.'  ;n
   ; mov byte[eax+29],'g'  ;o   
   ; mov byte[eax+31],'d'  ;p
   ; mov byte[eax+33],'a'  ;q  ?
   ; mov byte[eax+35],'s'  ;r
   ; mov byte[eax+37],'l'  ;s   
   ; mov byte[eax+39],'k'  ;t
   ; mov byte[eax+41],'m'  ;u
   ; mov byte[eax+43],'j'  ;v
   ; mov byte[eax+45],'n'  ;w
   ; mov byte[eax+47],'b'  ;x ?
   ; mov byte[eax+49],'z'  ;y
   ; mov byte[eax+51],'v'  ;z ?
   ; mov byte[eax+53],'c'  ;spatiu
   ; mov byte[eax+55],'x'  ;.
   
   mov eax,[ebp+8] ; adresa tabel
    mov byte[eax+1],'q'   ;a
    mov byte[eax+3],'x'   ;b
    mov byte[eax+5],' '   ;c
    mov byte[eax+7],'p'   ;d
    mov byte[eax+9],'d'   ;e
    mov byte[eax+11],'l'  ;f
    mov byte[eax+13],'o'  ;g
    mov byte[eax+15],'m'  ;h
    mov byte[eax+17],'i'  ;i  
    mov byte[eax+19],'v'  ;j
    mov byte[eax+21],'t'  ;k
    mov byte[eax+23],'s'  ;l
    mov byte[eax+25],'u'  ;m
    mov byte[eax+27],'w'  ;n
    mov byte[eax+29],'j'  ;o   
    mov byte[eax+31],'b'  ;p
    mov byte[eax+33],'a'  ;q  ?
    mov byte[eax+35],'k'  ;r
    mov byte[eax+37],'r'  ;s   
    mov byte[eax+39],'g'  ;t
    mov byte[eax+41],'f'  ;u
    mov byte[eax+43],'z'  ;v
    mov byte[eax+45],'c'  ;w
    mov byte[eax+47],'.'  ;x ?
    mov byte[eax+49],'h'  ;y
    mov byte[eax+51],'y'  ;z ?
    mov byte[eax+53],'e'  ;spatiu
    mov byte[eax+55],'n'  ;.
   
    mov ecx,[ebp+12] ; mesaj final 
        
    leave
    ret