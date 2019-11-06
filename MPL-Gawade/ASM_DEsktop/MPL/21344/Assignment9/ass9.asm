;-------------------------macro for printing and reading data----------------------

	%macro print 2
	mov rax,1
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	%macro read 2
	mov rax,0
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	
;------------------------------------------------------------------------------------





section .data

msg db "WORKS",10


section .bss
excnt resb 1
lcnt resb 1
num1 resb 2
count resb 1
excntb resb 1
con resb 8



section .text

    global _start:
    	_start:
    	
    	print msg,10
    	
    	pop rbx
    	pop rbx
    	pop rbx
    	
    	print msg,10
    	
    	mov byte[num1],bl
    	call atoh
    	
    	print msg,10
    	
    	
    	mov byte[num1],al
    	
    	mov byte[excnt],al
    	mov byte[excntb],al ;----It keeps original value----
    	
    	pushstack:
    		push rax
    		dec byte[rax]
    		dec byte[excnt]
    		
    		jnz pushstack
    		
    	print msg,10
    	
    	popstack:
    	
    		;---Moving the value of original number and decrementing by one as stack operates n-1 times
    		
    		
    		xor rax,rax
    		mov al,byte[excntb]
    		mov byte[excnt],al
    		
    		dec byte[excnt]
    		
    	loop1:
    		xor rax,rax
    		pop rbx
    		mov byte[lcnt],bl
    		pop rbx
    multiply:
    		add rax,rbx
    		dec byte[lcnt]
    		jnz multiply
    		
    		push rax
    		dec byte[excnt]
    		jnz loop1
    		
    endofloop:
    		pop rax
    	;-----Convert rax from hex to asccci and print -------
    		
    		mov byte[num1],al
    		mov al,byte[num1]
    		call a
    		
   exit:
   
   	mov rax,60
	mov rdi,0h
	syscall
    		
    		
    		
    		
    		
 ;-------ascii to hex------------- 
  atoh:

	mov esi,num1
	mov byte[count],2h
	xor ax,ax

	up1:
	rol ax,4
	cmp byte[esi],39h
	jbe up2
	sub byte[esi],07h
	up2:
	sub byte[esi],30h
	
	add al,byte[esi]
	inc esi 
	dec byte[count]
	jnz up1
	
	xor dx,dx
	ret
	
	
	
;-----hex to asciiiii-------------	


a:
 mov edi,con
 mov byte[count],8h
b: 
 rol eax,4
 mov bl,al
 and bl,0Fh
 cmp bl,9h
 jbe l1
 add bl,7h

 l1:
 add bl,30h
 mov byte[edi],bl
 inc edi
 dec byte[count]
 jnz b
	
 mov eax,4
 mov ebx,1
 mov ecx,con
 mov edx,8
 int 80h
  ret 

   
   	
    	
    	
