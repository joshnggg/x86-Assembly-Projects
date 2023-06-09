#Prompt the user for input values:
#Value for x
#Value for y
#Given the values provided by the user:
#Call a procedure to calculate the sum x + y
#Display the resulting sum
#Call a procedure to calculate the difference x – y
#Display the resulting difference
#Call a procedure to calculate the product x * y
#Display the resulting product
#Exit and return 0
.data
prompt_x:
    .string "Enter the value for x: "
prompt_y:
    .string "\nEnter the value for y: "
result_sum:
    .string "\nSum: "
result_diff:
    .string "\nDifference: "
result_prod:
    .string "\nProduct: "

.bss
    .lcomm x,1
    .lcomm y,1
    .lcomm z,1

.text
.global main

main:
    #prompt user for x
    movq $4, %rax
    movq $1, %rbx
    movq $prompt_x, %rcx
    movq $22, %rdx
    int $0x80
    
    #read the x
    movq $3, %rax
    movq $0, %rbx
    movq $x, %rcx
    movq $2, %rdx
    int $0x80
    
    #prompt user for y
    movq $4, %rax
    movq $1, %rbx
    movq $prompt_y, %rcx
    movq $23, %rdx
    int $0x80

    #read y
    movq $3, %rax
    movq $0, %rbx
    movq $y, %rcx
    movq $2, %rdx
    int $0x80

    #calculate the sum x+y subroutine and convert back to ascii for display
    call sum
    movq %rax, %rdi
    movq %rdi, z
    addq $0x30, z
    
    #prompt user sum  
    movq $4, %rax
    movq $1, %rbx
    movq $result_sum, %rcx
    movq $7, %rdx
    int $0x80 
    
    #read sum
    movq $4, %rax
    movq $1, %rbx
    movq $z, %rcx
    movq $1, %rdx
    int $0x80
    
    #calculate the difference x–y and convert ascii
    call diff
    movq %rax, %rdi
    movq %rdi, z
    addq $0x30, z
    
    #prompt user diff
    movq $4, %rax
    movq $1, %rbx
    movq $result_diff, %rcx
    movq $14, %rdx
    int $0x80 
    
    #read diff
    movq $4, %rax
    movq $1, %rbx
    movq $z, %rcx
    movq $1, %rdx
    int $0x80

    #calculate the product x*y and convert ascii 
    call mult
    movq %rax, %rdi
    movq %rdi, z
    addq $0x30, z
    
    #prompt user mult
    movq $4, %rax
    movq $1, %rbx
    movq $result_prod, %rcx
    movq $10, %rdx
    int $0x80 
    
    #read mult
    movq $4, %rax
    movq $1, %rbx
    movq $z, %rcx
    movq $1, %rdx
    int $0x80
    
#exit and return 0
exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
    
sum:
    movq x, %rdi
    movq y, %rsi
    subq $0x30, %rdi
    subq $0x30, %rsi
    movq %rdi, %rax
    addq %rsi, %rax
    ret

diff:
    movq x, %rdi
    movq y, %rsi
    subq $0x30, %rdi
    subq $0x30, %rsi
    movq %rdi, %rax
    subq %rsi, %rax
    ret
    
mult:
    movq x, %rdi
    movq y, %rsi
    subq $0x30, %rdi
    subq $0x30, %rsi
    movq %rdi, %rax
    imulq %rsi, %rax
    ret
