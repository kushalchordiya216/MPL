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
len equ $-msg


section .bss
excnt resb 1
lcnt resb 1
num1 resb 2
count resb 1
excntb resb 1
con resb 8
num2 resb 2



section .text

    global _start:
    	_start:
    	
    	print msg,len
    	
    	pop rbx
    	pop rbx
    	pop rbx
    	
    	
    	
    	mov byte[num1],bl
    	call atoh
    	
    	mov byte[num1],al
    	
    	
    	
    	
    	
    	mov byte[excnt],al
    	mov byte[excntb],al ;----It keeps original value----
    	mov rbx,rax
    	
    	
    	pushstack:
    		
    		push rbx
    		mov byte[num2],bl
    		dec byte[num2]
    		mov bl,byte[num2]
    		
    		dec byte[excnt]
    		
    		jnz pushstack
    		
    	print msg,len
    	
  
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
	
    		  	
    	
    	
