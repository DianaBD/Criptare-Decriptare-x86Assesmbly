GLOBAL xor_strings
extern strlen
    
xor_strings:
        push ebp
        mov ebp,esp
        
        mov ebx,[ebp + 8]  ; str1
        
        push ebx
        call strlen
        add esp,4
        mov ecx,eax
        
        mov edx,[ebp + 12] ; str1
        mov ebx,[ebp + 8]  ; str2
   
       xor_loop: 
            push ecx
            
            xor eax,eax
            xor ecx,ecx
            
            mov al,byte[edx]
            mov cl,byte[ebx]

            xor al,cl
            mov byte[edx],al
            pop ecx
            
            inc edx
            inc ebx
            dec ecx
            cmp ecx,0
            jnz xor_loop
       
       ;mov eax,[ebp + 16]
       ;push eax 
       ;call puts 
       ;add esp,4 
       leave
       ret
       