section .data
arr dd 0xFFFFFFFF,6,0xFFFFFFFA,0xFFF67854,2
msg db "The no. of negative numbers are:",0Ah
len equ $- msg
msg1 db "The no. of positive numbers are:",0Ah
len1 equ $-msg1
count db 00h
i dw 00h

section .bss
pos_count resb 10
neg_count resb 10

section .text
global _start
_start:
	mov esi,arr
	mov byte[pos_count],0h
	mov byte[neg_count],0h	

	up:
	mov eax,dword[esi]
	add eax,0h
	js neg
	inc byte[pos_count]
	jmp next
	

	neg:
	inc byte[neg_count]
	jmp next

	next:
	add esi,4
	add byte[count],1h
	cmp byte[count],5h
	jbe up
	
	add byte[pos_count],30h
	add byte[neg_count],30h

	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,neg_count
	mov edx,8
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,pos_count
	mov edx,8
	int 80h

	mov eax,1
	mov ebx,0
	int 80h
