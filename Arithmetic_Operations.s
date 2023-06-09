#Prompt the user for input values:
#Slope, m
#Y-intercept, b
#Value for x
#Given the values provided by the user, calculate the corresponding value for y using the linear equation slope-intercept form, y = mx + b
#Display the resulting value for y
#Exit and return 0
.data
ask_slope:
    .string "Input a slope, m: "
ask_intercept:
    .string "\nInput a Y-intercept, b: "
ask_x:
    .string "\nInput a value for x: "
result:
    .string "\nThe value of y is: "

.bss
    .lcomm slope, 2
    .lcomm intercept, 2
    .lcomm x, 2
    .lcomm y, 2

.section .text
.global main

main:
    #prompt user for the slope
    movq $4, %rax
    movq $1, %rbx
    movq $ask_slope, %rcx
    movq $19, %rdx
    int $0x80

    #read the slope m
    movq $3, %rax
    movq $0, %rbx
    movq $slope, %rcx
    movq $2, %rdx
    int $0x80

    #prompt user for y-intercept
    movq $4, %rax
    movq $1, %rbx
    movq $ask_intercept, %rcx
    movq $26, %rdx
    int $0x80

    #read the y-intercept b
    movq $3, %rax
    movq $0, %rbx
    movq $intercept, %rcx
    movq $2, %rdx
    int $0x80

    #prompt user for x
    movq $4, %rax
    movq $1, %rbx
    movq $ask_x, %rcx
    movq $21, %rdx
    int $0x80

    #read x
    movq $3, %rax
    movq $0, %rbx
    movq $x, %rcx
    movq $1, %rdx
    int $0x80

    #calculate y = mx + b and convert ascii
    movq slope, %rax
    subq $0x30, %rax      
    movq %rax, %rbx       
    movq x, %rax
    subq $0x30, %rax      
    imulq %rbx, %rax      
    movq intercept, %rbx
    subq $0x30, %rbx      
    addq %rbx, %rax       
    movq %rax, y
    addq $0x30, y         

    #display the resulting value of y
    movq $4, %rax
    movq $1, %rbx
    movq $result, %rcx
    movq $20, %rdx
    int $0x80
    
    movq $4, %rax
    movq $1, %rbx
    movq $y, %rcx
    movq $2, %rdx
    int $0x80

    #exit and return 0
    movq $60, %rax
    int $0x80
