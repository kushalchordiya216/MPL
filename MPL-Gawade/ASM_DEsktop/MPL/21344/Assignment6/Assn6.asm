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
	
;------------------------------------------------------

section .data
msg db "Data is:",10
newline db 10
len equ $-msg

section .bss
gdt resb 2
ldt resb 2
idt resb 2
result resb 4
temp resb 2


section .text

global _start
 _start:
 
;------------------SGDT--------------------

SGD:
	sgdt[gdt]
	
	mov ax,word[gdt]
	call hta
	
;--------Print address of SGDT------
;+-------prints adddressss-----------

	mov ax,word[gdt+4]
	call hta

	mov ax, word[gdt+2]
	call hta
;-----------------------------------
	

;-------------idt--------------------

	sidt[idt]
	
	mov ax,word[idt]
	call hta
;---------------adddreeeee-------------	
	mov ax,word[idt+4]
	call hta

	mov ax, word[idt+2]
	call hta
;--------------------------adresss------------


;-----------ldt------------------

	sldt[ldt]
	
	mov ax,word[ldt]
	call hta	

;---------------exit-------------
	
	exit:
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


