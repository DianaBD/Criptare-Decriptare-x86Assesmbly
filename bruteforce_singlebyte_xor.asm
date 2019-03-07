GLOBAL bruteforce_singlebyte_xor
extern strlen

bruteforce_singlebyte_xor:
     push ebp
     mov ebp, esp  
     
     ;[ebp + 12] adresa finala a cheii
     ;[ebp + 8] adresa sirului codificat
     ;[ebp - 3900] unde pun sirul xorat
     ;[ebp - 3500] variabila OK
     ;[ebp - 4000] unde se pune "force"
     xor edx,edx ; valoarea initiala pt cheie e 0
     
     mov byte[ebp-3500],0;pe post de OK
     while_not_OK:
        
        ; se xoreaza sirul cu cheia si se pune la adresa ebp-3900
        mov ebx,[ebp + 8] ; adresa sir codificat
        lea ecx,[ebp- 3900] ; unde pun sirul xorat
        get_xored_string:
            mov al,byte[ebx]
            cmp al,0
            jz end_get_xored_string
            xor al,dl
            mov byte[ecx],al
            inc ecx
            inc ebx
            jmp get_xored_string
        end_get_xored_string:
            mov byte[ecx],al    
        
        ;se pune "force " la adresa ebp-4000 salvata in eax
        lea eax,[ebp-4000]; adresa la care pun cuvantul force
        mov dword[eax],0x63726F66
        mov word[eax+4],0x0065
        
        lea ebx,[ebp-3900] ;sir xorat
        ;se compara fiecare grup de 5 bytes cu "force"
        while_string_didnt_end:
            mov ecx,5
            lea esi,[ebp-4000]  ;"force"
            lea edi,[ebx]  ;sirul xorat
            repe cmpsb
            cmp ecx,0
            jnz not_OK ; daca a gasit "force" OK=1
                mov byte[ebp-3500],1
            not_OK:
            inc ebx 
            
            ;daca s-a terminat sirul iese din bucla
            mov al,byte[ebx]
            cmp al,0
            jnz while_string_didnt_end
            
       end_while_string_didnt_end:
       
       ;verifica daca OK=1 si daca da, se iese din bucla while_not_OK
       mov al,byte[ebp-3500]
       cmp al,1
       jz bingo ;am gasit cheia
       inc edx
       jmp while_not_OK
       
     bingo: 
     
     
     lea ebx,[ebp-3900]
     push ebx
     call strlen
     add esp,4
  
    ;copiaza sirul decodificat peste sirul initial
     mov ecx,eax
     lea esi,[ebp-3900] 
     mov edi,[ebp+8]
     rep movsb

    ;copiaza cheia la adresa salvata in ebp+12
     mov eax,[ebp+12]
     mov [eax],edx
     
     leave
     ret
     