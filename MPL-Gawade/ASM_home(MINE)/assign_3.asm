;--------------macro printing and reading data----------
 	
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
db "1 for HEX TO BCD",10
db "2 for BCD TO HEX",10
db "3 for EXIT",10
menulen equ $-menu

msg1 db "Enter hex number"
len1 equ $-msg1

msg2 db "Hexadecimal Number is"
len2 equ $-msg2

msg3 db "Enter bcd number"
len3 equ $-msg3

msg4 db "BCD Number is"
len4 equ $-msg4

newline db 10
dash db '-'

section .bss

cnth resb 1
cntb resb 1
cnt_push resb 1
numh resb 5
numb resb 5
asciidigit resb 1
display resb 8

choice resb 2


section .text

global _start:

_start:

;------------------menu-----------------
	main:
	
	print menu,menulen
	
	read choice,2

	cmp byte[choice],31h
	je HEXTOBCD
	

	cmp byte[choice],32h
	je BCDTOHEX
	

	cmp byte[choice],33h
	je EXIT
	
;----------------HEX TO BCD----------------------	
;---------------accept hex number---------------

	HEXTOBCD:
	
	print msg1,len1
	print newline,1
	
	read numh,5
	mov byte[cnth],4h
	mov rsi,numh
	call atoh

;---------------------------hex to bcd----------------
	
	htob:
	
	mov byte[cnt_push],0h
	mov rax,0h
	mov ax,bx
	xor rdx,rdx
	mov rbx,0Ah

	up:
	div rbx
	push dx
	mov rdx,0h
	inc byte[cnt_push]
	cmp ax,0h
	jnz up
	
;-----------------------print bcd---------------------

	print msg4,len4
	print newline,1
	down:
	pop dx
	add dl,30h
	mov byte[asciidigit],dl
	print asciidigit,1
	dec byte[cnt_push]
	jnz down
	
	print newline,1
	jmp main
	
;----------------------BCD TO HEX---------------------------
;-----------------------accept bcd number-------------

	BCDTOHEX:

	print msg3,len3
	print newline,1
	read numb,5

	mov byte[cnth],5h
	mov rsi,numb
	
	xor rax,rax
	xor r8,r8
	mov eax,10000
	mov r10,10000
	mov r9,10

	loop:

	xor ebx,ebx
	mov bl,byte[rsi]
	sub bl,30h
	mul ebx
	add r8,rax
	mov rax,r10
	div r9
	mov r10,rax

	inc rsi
	dec byte[cnth]
	jnz loop

	xor rax,rax
	mov rax,r8
	hta:
	mov rdi,display
	mov byte[cnth],16h
	
	l1:
	rol rax,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l2
	add bl,7h
	
	l2:
	add bl,30h
	mov byte[rdi],bl

	inc rdi
	dec byte[cnth]
	jnz l1
	
	print msg2,len2
	print newline,1
	print display,16
	print newline,1

	jmp main
		
;-------------------------exit-------------------

	EXIT:
	
	mov rax,60
	mov rdx,0h
	syscall

	;jmp main
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
	
	
	
		
