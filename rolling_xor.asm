GLOBAL rolling_xor
extern strlen

rolling_xor:
        push ebp
        mov ebp,esp
        
        mov edx,[ebp + 8] ;adresa inceput sir3
        ;mov ebx,[ebp + 8] ;lungime sir3
        push edx
        call strlen
        add esp,4
        mov ebx,eax
        
        mov edx,[ebp + 8] ;adresa inceput sir3
        
        add edx,ebx ;adresa sfarsit sir3
        sub edx,2 ;penultimul caracter din sir3
        for2:
            xor ecx,ecx
            xor eax,eax
            mov cl,[edx];penultimul caracter
            inc edx ;adresa ultimul caracter
            mov al,[edx];ultiul caracter
            xor al,cl
            mov byte[edx],al
            sub edx,2 ;urmatorul caracter de la coada la cap
            
            dec ebx
            cmp ebx,0
            jnz for2
            
        mov edx,[ebp + 8]
        leave
        ret
