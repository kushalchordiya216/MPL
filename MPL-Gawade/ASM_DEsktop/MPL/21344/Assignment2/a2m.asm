section .data
arr dd 0x1,0x2,0x3
arr1 dd 0x4,0x5,0x6
arr2 dd 0x2,0x3,0x4
arr3 dd 0x5,0x6,0x7
new db 10

dash db '-'
colon db ':'
break db 'O'
section .bss
 con resb 8
 count resb 8
count1 resb 8

 section .text
  global _start
  _start:
 mov byte[count1],03h
 
  mov esi,arr
strt:
  mov eax,esi
  call a
  
  mov eax,4
  mov ebx,1
  mov ecx,dash
  mov edx,1
  int 80h
  
  mov eax,[esi]
  call a 
  
  add esi,4
  dec byte[count1]

  mov eax,4
  mov ebx,1
  mov ecx,colon
  mov edx,1
  int 80h
  jnz strt

;Overlapping block transfer
mov byte[count1],03h
mov esi,arr
mov edi,arr1
  
  
 
  strt1:
  mov eax,[esi]
  mov [edi],eax
  add esi,4
  add edi,4
  dec byte[count1]
  
  jnz strt1
  
  
  


  mov esi,arr1
  mov byte[count1],03h
print:
  mov eax,esi
  call a
  
   mov eax,4
  mov ebx,1
  mov ecx,dash
  mov edx,1
  int 80h


  mov eax,[esi]
  call a

 mov eax,4
  mov ebx,1
  mov ecx,colon
  mov edx,1
  int 80h
  
  add esi,4
  dec byte[count1]
  jnz print


 
  mov eax,4
  mov ebx,1
  mov ecx,break
  mov edx,1
  int 80h 

 mov esi,arr
 mov edi,arr
 add edi,10h
 add esi,8h
 

 mov byte[count1],03h
 strt3:
  mov eax,[esi]
  mov [edi],eax
  sub esi,4
  sub edi,4
  dec byte[count1]
  jnz strt3

  mov esi,arr
  add esi,8
  mov byte[count1],03h
  print2:

  mov eax,esi
  call a
  
   mov eax,4
  mov ebx,1
  mov ecx,dash
  mov edx,1
  int 80h


  mov eax,[esi]
  call a

 mov eax,4
  mov ebx,1
  mov ecx,colon
  mov edx,1
  int 80h
  
  add esi,4
  dec byte[count1]
  jnz print2
   
  ;Non overlapping String
  
  mov ecx,03h
  mov esi,arr
  mov edi,arr1
  rep movsd

  mov byte[count1],03h
  mov esi,arr1
  sub esi,4h

  printso:
    add esi,4h
    mov eax,esi
    call a

     mov eax,4
     mov ebx,1
     mov ecx,dash
     mov edx,1
     int 80h
     
     mov eax,[esi]
     call a

     mov eax,4
     mov ebx,1
     mov ecx,colon
     mov edx,1
     int 80h

     dec byte[count1]
     jnz printso

;Overlapping String 

      mov ecx,03h
      mov esi,arr2
      add esi,8h
      mov edi,arr2
      add edi,10h
      std
      rep movsd

      mov byte[count1],03h
      mov esi,arr2
      sub esi,4h

      printso1initialblock:
       add esi,4
     mov eax,esi
     call a 
  
     mov eax,4
     mov ebx,1
     mov ecx,dash
     mov edx,1
     int 80h
     
     mov eax,[esi]
     call a
  
      mov eax,4
     mov ebx,1
     mov ecx,colon
     mov edx,1
     int 80h


     dec byte[count1]
     jnz  printso1initialblock
  
      
       

     

     mov byte[count1],03h
     mov esi,arr2
     add esi,4h

    printso1:
     add esi,4
     mov eax,esi
     call a 
  
     mov eax,4
     mov ebx,1
     mov ecx,dash
     mov edx,1
     int 80h
     
     mov eax,[esi]
     call a
  
      mov eax,4
     mov ebx,1
     mov ecx,colon
     mov edx,1
     int 80h


     dec byte[count1]
     jnz printso1
  
     
     

     
     
    
    
      


    
    
   

   mov eax,1
  mov ebx,0
  int 80h




a:
 mov edi,con
 mov byte[count],8h
b: 
 rol eax,4
 mov bl,al
 and bl,0Fh
 cmp bl,9h
 jbe l1
 add bl,7h

 l1:
 add bl,30h
 mov byte[edi],bl
 inc edi
 dec byte[count]
 jnz b
	
 mov eax,4
 mov ebx,1
 mov ecx,con
 mov edx,8
 int 80h
  ret 

   
   
   

   

