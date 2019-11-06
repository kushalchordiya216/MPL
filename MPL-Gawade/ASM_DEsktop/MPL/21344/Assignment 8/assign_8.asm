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

msg db "file opened successfully",10
len equ $-msg

msg1 db "error opening file",10
len1 equ $-msg1

msg2 db "file closed successfully",10
len2 equ $-msg2

msg3 db "file deleted successfully",10
len3 equ $-msg3

section .bss

fname1 resb 1
fname2 resb 1
fd1 resq 1
fd2 resq 1
temp resb 50
length resq 1


section .text

global _start

	_start:
	
	pop rbx
	pop rbx 
	pop rbx
	
	cmp byte[rbx],74h
	je TYPE
	
	cmp byte[rbx],63h
	je COPY
	
	cmp byte[rbx],64h
	je DELETE
	
	jmp EXIT
	
	;-------------------type--------------
	
	TYPE:
	
	pop rbx
	
	mov rsi,fname1
	
	label:
	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jnz label
	
		;----------------opening a.txt-----------
			
			mov rax,2
			mov rdi,fname1
			mov rsi,2
			mov rdx,0777
			syscall ;-------returns fd in rax
			
			mov qword[fd1],rax
        		BT rax , 63 ;----Check if file is opened sucessfully
       			jc label2
       			
       			print msg , len ;-----File sucessfully opened
       			jmp label1
       			
   			label2 : print msg1 , len1 ;--Unsucessful
  			jmp EXIT
			
		;-----------reading a.txt-----------
		
			label1:
			
			mov rax,0
			mov rdi,[fd1]
			mov rsi,temp
			mov rdx,50
			syscall ;--------returns len in rax
			
			mov qword[length],rax
			
		;----------------writing to console---------
		
			print temp,[length]
			
		;-----------------closing the file-----------
		
			mov rax,3
			mov rdi,[fd1]
			syscall
			print msg2,len2
			
			
			jmp EXIT
	
	;-------------------copy-------------
	
	COPY:
	
	pop rbx
	
	mov rsi,fname1
	
	cp1:
	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jnz cp1
	
	;------------opening a.txt ----------------
		
			mov rax,2
			mov rdi,fname1
			mov rsi,2
			mov rdx,0777
			syscall ;-------returns fd in rax
			
			mov qword[fd1],rax
        		BT rax , 63
       			jc label3
       			
       			print msg , len
       			jmp label4
       			
   			label3 : print msg1 , len1
  			jmp EXIT
			
		;-----------reading a.txt-----------
		
			label4:
			
			mov rax,0
			mov rdi,[fd1]
			mov rsi,temp
			mov rdx,50
			syscall ;--------returns len in rax
			
			mov qword[length],rax
	
	pop rbx
	
	mov rdi,fname2
	
	cp2:
	mov al,byte[rbx]
	mov byte[rdi],al
	inc rdi
	inc rbx
	cmp byte[rbx],0
	jnz cp2
	
		
			
		;------------opening b.txt-----------
		
			mov rax,2
			mov rdi,fname2
			mov rsi,2
			mov rdx,0777
			syscall ;-------returns fd in rax
			
			mov qword[fd2],rax
        		BT rax , 63
       			jc label5
       			
       			print msg , len
       			jmp label6
       			
   			label5 : print msg1 , len1
  			jmp EXIT
  			
  		;--------------writing to b.txt------------
  		
  			label6:

			mov rax,01
			mov rdi,[fd2]
			mov rsi,temp
			mov rdx,[length]
			syscall
			
		;----------------closing a.txt---------------
		
			mov rax,3
			mov rdi,[fd1]
			syscall
			print msg2,len2
			
		;----------------closing b.txt---------------
		
			mov rax,3
			mov rdi,[fd2]
			syscall
			print msg2,len2
			
			jmp EXIT
	
	
	;------------------delete---------------
	
	DELETE:
	
	pop rbx
	
	mov rsi,fname1
	
	del1:
	mov al,byte[rbx]
	mov byte[rsi],al
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jnz del1
	
		;------------delete call------------
		
			mov rax,87
			mov rdi,fname1
			syscall
			print msg3,len3
			
		jmp EXIT
	
		
	;----------------exit--------------
	
	EXIT :
	mov rax,60
	mov rdi,0h
	syscall


	
