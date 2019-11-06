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
msg db "WORKS",10
len equ $-msg

section .bss
factorial resb 16
cnth resb 2
num resb 16
num1 resb 16
num2 resb 16
factor resb 16
cnta resb 2
cnt_push resb 2
cnt1 resb 2

section .text

 global _start
    _start:
    
jmp bth


    read num,5
    call atoh
    mov byte[num1],bl
    print msg,len
    mov byte[cnt_push],0h
    
    

htb:
    mov rax,0h
    mov rax,rbx
    mov rbx,10
    xor rdx,rdx

loop3:
    div rbx
    push dx
    inc byte[cnt_push]
    mov rdx,0h
    cmp rax,0h 
    jne loop3

print msg,len
disp:
    pop dx 
    add dl,30h
    mov byte[num2],dl
    print num2,2
    dec byte[cnt_push]
    jnz disp
    jmp exit


bth:
    read num,4

    mov rcx,4
	mov rsi,num+3
	mov rbx,0
	mov qword[factor],1

    loop4:
	mov rax,0	
	mov al,[rsi]
    sub al,30h
	mul qword[factor]
	add rbx,rax
	mov rax,10
	mul qword[factor]
	mov qword[factor],rax
	dec rsi
	loop loop4

    mov rax,rbx


disp1:
    call hta
    print factorial,4

    




exit:
    mov rax,60
    mov rdi,0
    syscall











atoh: 
    xor ax,ax
	xor bx,bx
    mov rsi,num ;num is input
    mov byte[cnth],4h

loop2:
    mov al,byte[rsi]
    rol bx,4h
    sub al,30h
    cmp al,9h
    jbe h1

    sub al,7h

h1:
    add bx,ax
    inc rsi
    dec byte[cnth]  ;cnth has total number of digits
    jnz loop2
    ret

;---result in bl -----------
    



hta:
	mov rdi,factorial
	mov byte[cnta],16h
	
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
	dec byte[cnta]
	jnz l2
	
	ret

