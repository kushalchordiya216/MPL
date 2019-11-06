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


section .data
msg db "Works",0
len equ $-msg

section .bss
num resb 5
num1 resb 5
cnth resb 2
cnt_push resb 2
num2 resb 5

section .text

    global _start
     _start:
    
hextobcd:
 ;------accept number--------------
    read num,5
    mov rsi,num
    mov byte[cnth],4h
    call atoh
    mov byte[num1],bl
    mov byte[cnt_push],0h

    ;----------conversion-----------
    mov rax,0h
    mov rax,rbx
    mov rbx,10
    xor rdx,rdx

loop:
    div rbx
    push dx
    inc byte[cnt_push]
    mov rdx,0h
    cmp rax,0h
    jne loop
    

print1:
    pop dx
    add dl,30h
    mov byte[num2],dl
   print num2,2
    dec byte[cnt_push]
    jnz print1 
    ;print msg,len
  exit:
    mov rax,60
    mov rdi,0h
    syscall  








 ;----------------ascii to hex-------------------

	atoh:
	
	xor ax,ax
	xor bx,bx
	
	hex:
	mov al,byte[rsi]
	rol bx,4h
	sub al,30h
	cmp al,9h
	jbe next
	
	sub al,7h
	
	next:
	add bx,ax
	inc rsi
	dec byte[cnth]
	jnz hex

	ret