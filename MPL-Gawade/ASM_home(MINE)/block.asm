



    
    

    

    
       




exit:
    mov rax,60
    mov rdi,0
    syscall


	hta:
	mov rdi,factorial
	mov byte[cnth],8h
	
	l2:
	rol ax,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l3
	add bl,7h
	
	l3:
	add bl,30h
	mov byte[rdi],bl

	inc rdi
	dec byte[cnth]
	jnz l2
	
	ret

   