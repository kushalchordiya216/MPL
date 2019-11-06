;--------------macro for printing and reading--------------

	%macro print 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	
	int 80h
	%endmacro

	
	%macro read 2
	mov eax,3
	mov ebx,0
	mov ecx,%1
	mov edx,%2
	
	int 80h
	%endmacro
	
;--------------------------------------------------------
section .data

msg db "Contents of gdtr are: ",10
len equ $-msg

msg1 db "Contents of ldtr are: ",10
len1 equ $-msg1

msg2 db "Contents of idtr are: ",10
len2 equ $-msg2

msg3 db "Base address",10
len3 equ $-msg3

msg4 db "Base limit",10
len4 equ $-msg4

newline db 10

section .bss

gdt resb 2
ldt resb 2
idt resb 2

result resb 4


section .text

global _start

	_start:
	
;----------print contents of gdtr----------

	label:
	sgdt[gdt]
	print msg,len
	print newline,1
	
	print msg4,len4
	mov ax,word[gdt]
	call hta
	
	print msg3,len3
	mov ax,[gdt+4]
	call hta

	mov ax,[gdt+2]
	call hta
	
	
	
;----------print contents of idtr----------

	label1:
	sidt[idt]
	print msg2,len2
	print newline,1
	
	print msg4,len4
	mov ax,word[idt]
	call hta
	
	print msg3,len3
	mov ax,[idt+4]
	call hta

	mov ax,[idt+2]
	call hta
	
	
;----------print contents of ldtr----------

	label2:
	sldt[ldt]
	print msg1,len1
	print newline,1
	

	mov ax,word[ldt]
	call hta

	
;-------------------exit----------------

	Exit:
	mov eax,1
	mov ebx,0
	int 80h
		
	
;---------------hex to ascii--------------

hta:
	mov edi,result
	mov ecx,4h
	
	l1:
	rol ax,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l2
	add bl,7h
	
	l2:
	add bl,30h
	mov byte[edi],bl

	inc edi
	loop l1

	print result,4
	print newline,1
	ret


