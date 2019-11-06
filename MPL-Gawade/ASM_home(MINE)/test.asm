%macro print 2
mov rax,1
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro


section .data
arr db 0x1,0x2,0x3
arr1 db 0x4,0x5,0x6

section .bss
factorial resb 4
cnth resb 4
cnt resb 2

section .text
 global _start
  _start:

	mov rdi,arr
	mov rsi,arr1
	mov byte[cnt],3

p:
	mov r8,[rdi]
	mov [rsi],r8
	inc rsi
	inc rdi
	dec byte[cnt]
	jnz p

	sub rsi,3

	push rsi
	mov al,byte[rsi]
	call hta
	print factorial,4

	pop rsi
	inc rsi
	mov al,byte[rsi]
	call hta
	print factorial,4






	

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