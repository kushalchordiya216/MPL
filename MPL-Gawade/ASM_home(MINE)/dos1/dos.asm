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
file1 db "orig.txt",0
file2 db "cpy.txt",0

section .bss
fd1 resq 8
fd2 resq 8
length resq 2
var resb 100
var1 resb 100

section .text

    global _start
        _start:

    ;-----------open file-------------
        mov rax,2
        mov rdi,file2
        mov rsi,2
        mov rdx,[length]
        Syscall

        mov qword[fd2],rax

        mov rax,0
        mov rdi,[fd2]
        mov rsi,var1
        mov rdx,100
        Syscall   

        print var1,100
        
              
            mov rax,2
            mov rdi,file1
            mov rsi,2
            mov rdx,0777
            syscall

            mov qword[fd1],rax

            mov rax,0
            mov rdi,[fd1]
            mov rsi,var
            mov rdx,100
            syscall   

            mov qword[length],rax
            print var,100

        
        
        
        
      
        

       
    ;------opening file 2------------------------------

       

       mov rax, 01
       mov rdi, [fd2]
        mov rsi, var
        mov rdx,[length]
        syscall

        mov rax,3
        mov rdi,[fd2]
        syscall

        mov rax,3
      mov rdi,[fd1]
        syscall

        mov rax,87
        mov rdi,file1
        syscall

        

    
    exit:
       

        mov rax,60
        mov rdi,0h
        syscall
