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
	
	

section .data

menu db "Enter choice:",10
db "1 for SUCCESSIVE ADDITION ",10
db "2 for ADD AND SHIFT",10
db "3 for EXIT",10
menulen equ $-menu

msg1 db "Enter first number",10
len1 equ $-msg1

msg2 db "Enter second number",10
len2 equ $-msg2

msg3 db "The result of multiplication is",10
len3 equ $-msg3

newline db 10
cnt db 00
count db 00


section .bss

choice resb 2
num1 resb 2
num2 resb 2
result resb 8



section .data

global _start

_start:

;------------------menu-----------------
	main:
	
	print menu,menulen
	read choice,3

	cmp byte[choice],31h
	je SUCC_ADD
	

	cmp byte[choice],32h
	je ADD_SHIFT
	

	cmp byte[choice],33h
	jae EXIT
;---------------------accept two numbers--------------

	SUCC_ADD:
	
	print msg1,len1
	read num1,3
	mov rsi,num1
	call atoh
	mov byte[num1],bl
	
	print newline,1
	
	print msg2,len2
	read num2,3
	mov rsi,num2
	call atoh
	xor rcx,rcx
	mov cl,bl
	
	
;----------------------successive multiplication---------------

	xor rbx,rbx
	mov bl,byte[num1]
	xor rax,rax
	mul1:
	cmp cl,0
	je label
	add rax,rbx
	loop mul1
	
	label:
	xor rdx,rdx
	mov rdx,rax
	
	call hta

	print msg3,len3
	print result,4h
	print newline,1
	
	jmp main
	
;--------------------------add and shift-------------------

	ADD_SHIFT:
	
	print msg1,len1
	read num1,3
	mov rsi,num1
	call atoh
	mov byte[num1],bl

	
	print newline,1
	
	print msg2,len2
	read num2,3	
	mov rsi,num2
	call atoh
	mov byte[num2],bl
	
	xor rbx,rbx
	xor rcx,rcx
	mov bl,byte[num1]
	mov cl,byte[num2]
	mov byte[count],8h
	xor rax,rax
	
	mul2:
	shl bl,1
	jnc up1
	
	add rax,rcx
	
	up1:
	shl rax,1
	dec byte[count]
	jnz mul2
	
	sar rax,1;---In above loop there is an extra shl so we do sar
	call hta
	
	print msg3,len3
	print result,4h
	print newline,1
	
	jmp main
	
	
	
;---------------exit--------------------

	EXIT:
	mov rax,60
	mov rdi,0h
	syscall

;-------------------ascii to hex--------------

	atoh:
	mov byte[cnt],2h
	xor ax,ax
	xor bx,bx
	
	hex:
	rol bl,4h
	mov al,byte[rsi]
	cmp al,39h
	jbe next
	
	sub al,7h
	
	next:
	sub al,30h
	add bl,al
	inc rsi
	dec byte[cnt]
	jnz hex

	ret
	
;-----------------------hex to ascii--------------------	
	hta:
	mov rdi,result
	mov byte[cnt],4h
	
	l1:
	rol ax,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l2
	add bl,7h
	
	l2:
	add bl,30h
	mov byte[rdi],bl

	inc rdi
	dec byte[cnt]
	jnz l1

	ret
	
