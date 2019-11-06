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
num1 resb 4
num11 resb 4
num2 resb 4
num22 resb 4
result resb 4
cnta resb 4
cnth resb 4
cnt resb 2


section .text
global _start
_start:

    read num1,4
    mov rsi,num1
    call ath
    mov byte[num11],bl
    
    read num2,4
    mov rsi,num2
    call ath
    mov byte[num22],bl

    xor rbx,rbx
    xor rcx,rcx
    ;mov bl,byte[num11]
   ; mov cl,byte[num22]
   ; mov byte[cnt],8h
   ; xor rax,rax
    jmp suc
    



shift:
    shl bl,1
    jnc up1

    add rax,rcx

up1:
    shl rax,1
    dec byte[cnt]
    jnz shift

    sar rax,1
    call hta

    print result,4


suc:
    mov rax,0h
    mov bl,byte[num11]

loops:
    add rax,rbx
    dec byte[num22]
    jnz loops

   ; mov byte[result],0h
    call hta
    print result,4


exit:
    mov rax,60
    mov rdi,0
    syscall











hta:
    mov rsi,result
    mov byte[cnta],16h

loop1:
    rol ax,4
    mov bl,al
    and bl,0Fh
    cmp bl,09h
    jbe l1
    add bl,07h

l1:
    add bl,30h
    mov byte[rsi],bl
    inc rsi
    dec byte[cnta]
    jnz loop1

    ret

ath:
    mov byte[cnth],2
    xor ax,ax
	xor bx,bx
	
    

loop2:
    rol bl,4h
    mov al,byte[rsi]
    cmp al,39h
    jbe l2
    sub al,07h

l2:
    sub al,30h
    add bl,al
    inc rsi
    dec byte[cnth]
    jnz loop2
    ret

