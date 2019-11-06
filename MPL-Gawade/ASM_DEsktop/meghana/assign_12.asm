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
;------------------------------------------------------

section .data

arr dd 101.00,102.00,103.00,104.00,105.00

msg db "The mean is",10
len equ $-msg

msg1 db "The variance is",10
len1 equ $-msg1

msg2 db "The standard deviation is",10
len2 equ $-msg2

dot db ".",0
dotl equ $-dot

newline db 10

section .bss
cnt resw 1
mean resd 1
variance resd 1
result rest 1
display resb 2
dev resd 1
cnt1 resb 1
hundred resw 1


section .text

	global _start
	
	_start:
	
	mov word[hundred],100
	mov word[cnt],05h
	;-----------------------mean-------------------
	
	MEAN:
	mov rcx,05h
	mov rsi,arr
	finit
	fldz
	
	label:
	fadd dword[rsi]
	add rsi,4
	loop label

	fidiv word[cnt]
	
	fst dword[mean]
	
	print msg,len
	call disp
	
	;-----------------variance-----------------------
	
	VARIANCE:
	mov rcx,05h
	mov rsi,arr
	fldz
	
	label2:
	fld dword[rsi]
	fsub dword[mean]
	fmul ST0
	fadd dword[variance]
	fstp dword[variance]
	
	add rsi,4
	loop label2
	
	fld dword[variance]
	fidiv word[cnt]
	
	fst dword[variance]
	
	print newline,1
	print msg1,len1
	call disp
	
	;------------------standard deviation--------------
	
	STD_DEV:
	fldz
	fld dword[variance]
	fsqrt
	fst dword[dev]
	print newline,1
	print msg2,len2
	call disp
	print newline,1
	
	;-------------exit------------------------------
	
	EXIT:
	mov rax,60
	mov rdx,0h
	syscall
	
	
	;--------------------display procedure--------------
	
	disp:
	
	fimul word[hundred]
	fbstp [result]
	xor rcx,rcx
	mov rcx,09
	mov rsi,result+9
	xor rax,rax
	
	tag:
	mov al,byte[rsi]
	push rsi
	push rcx
	call hta
	pop rcx
	pop rsi
	dec rsi
	loop tag
	
	print dot,dotl
	
	mov rsi,result
	mov al,byte[rsi]
	call hta
	
	ret
		
	
	;------------------hex to ascii---------------
	
	hta:
	mov rdi,display
	mov rcx,2
	
	
	l2:
	rol al,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l3
	add bl,7h
	
	l3:
	add bl,30h
	mov byte[rdi],bl

	inc rdi
	loop l2
	
	
	print display,2
	
	ret
