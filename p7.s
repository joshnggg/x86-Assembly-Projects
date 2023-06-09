.data
#intialize array of long
IntArray:
        .long 1, 1, 2, 3
result:
    .string "Sum: "

sum:
    .long 0
   
.text
.global main

main:
    #intialize sum(eax) and loop counter(ecx) to 0
    movl $0, %eax
    movl $0, %ecx
   
    #load array address into edi
    movl $IntArray, %edi
   
loop:
    #check loop end condition
    cmpl $4, %ecx
    jge exit
   
    #access elements and add elements to sum eax
    movl (%edi,%ecx,4), %ebx
    addl %ebx, %eax
   
    #increment counter ++ and jump back to loop:
    addl $1, %ecx
    jmp loop
   
exit:
    #convert sum to ascii and write
    addl $0x30, %eax
    movl %eax, sum
    movl $4, %eax
    movl $1, %ebx
    leal result, %ecx
    movl $5, %edx
    int $0x80
   
    #display result
    movl $4, %eax
    movl $1, %ebx
    movl $sum, %ecx
    movl $1, %edx
    int $0x80
    
    #exit program return 0
    movl $1, %eax
    movl $0, %ebx
    int $0x80