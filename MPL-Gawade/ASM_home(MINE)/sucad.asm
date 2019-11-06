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

section .bss
num1 resb 2
num2 resb 2
num11 resb 2
num22 resb 2
cnth resb 5
factorial resb 8

section .text

    global _start
        _start:
            read num1,4
            read num2,4
            mov byte[cnth],2h
            mov rsi,num1
            call atoh
            mov byte[num11],bl
            mov byte[cnth],2h
            mov rsi,num2
            call atoh
            mov byte[num22],bl
            xor rbx,rbx

        mul:
            mov bl,byte[num11]
            mov rax,0h

        loop:
            add rax,rbx
            dec byte[num22]
            jnz loop
            mov byte[factorial],0h
            call hta
            print factorial,4


        exit:
            mov rax,60
            mov rdi,0h
            syscall
        







;----------------hex to ascii----------------
	
	hta:
	mov rdi,factorial
	mov byte[cnth],4h
	
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