section .data

formatpf: db "%lf" , 10, 0
formatsf: db "%lf", 0

msg1 db "Write a,b,c"
len1 equ $-msg1 

four : dw 4

two : dw 2


section .bss

a resb 8
b resb 8
c resb 8

bsquare resq 1
fourac resq 1

delta resq 1

twoa resq 1
squareroot resq 1

root1 resq 1
root2 resq 1

r1 resq 1
i1 resq 1

r2 resq 1
i2 resq 1

%macro print 2
mov rax,1
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro myprintf 1
mov rdi,formatpf
sub rsp,8
movsd xmm0,[%1]
call printf
mov rax,1
add rsp,8
%endmacro

%macro myscanf 1
mov rdi,formatsf
mov rax,0
sub rsp,8
mov rsi,rsp
call scanf
mov r8,qword[rsp]
mov qword[%1],r8
add rsp,8
%endmacro




section .text
extern printf 
extern scanf

global main
    main:

    print msg1,len1
    myscanf a
    myscanf b
    myscanf c

    myprintf a
    myprintf b
    myprintf c

    finit
    fldz

    fadd qword[b]
    fmul st0
    fstp qword[bsquare]
    myprintf bsquare

    fldz
    fadd qword[a]
    fmul qword[c]
    fimul word[four]
    fstp qword[fourac]
    myprintf fourac

    fldz
    fadd qword[bsquare]
    fsub qword[fourac]
    fstp qword[delta]
    myprintf delta







    

    mov rax,60
    mov rdi,0
    syscall



    

