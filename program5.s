.data
prompt_x:
    .string "Enter the value for x: \n"
prompt_y:
    .string "Enter the value for y: \n"
msg_greater:
    .string "x > y\n"
msg_other:
    .string "x <= y\n"

.bss
    .lcomm x, 1
    .lcomm y, 1

.text
.global main

main:
    #prompt user for x
    movq $4, %rax
    movq $1, %rbx
    movq $prompt_x, %rcx
    movq $24, %rdx
    int $0x80

    #read x
    movq $3, %rax
    movq $0, %rbx
    movq $x, %rcx
    movq $1, %rdx
    int $0x80

    #prompt for y
    movq $4, %rax
    movq $1, %rbx
    movq $prompt_y, %rcx
    movq $24, %rdx
    int $0x80

    #read y
    movq $3, %rax
    movq $0, %rbx
    movq $y, %rcx
    movq $1, %rdx
    int $0x80

    #compare values of xy convert ascii
    movq x, %rdi
    subq $0x30, %rdi
    movq y, %rsi
    subq $0x30, %rsi
    cmpq %rsi, %rdi

    #if true x>y jump to greater section
    jg greater

    #else x <= y
    movq $4, %rax
    movq $1, %rbx
    movq $msg_other, %rcx
    movq $8, %rdx
    int $0x80
    jmp exit

greater:
    # x>y display msg
    movq $4, %rax
    movq $1, %rbx
    movq $msg_greater, %rcx
    movq $6, %rdx
    int $0x80
    jmp exit

exit:
    #exit and return 0
    movq $60, %rax
    xorq %rdi, %rdi
    int $0x80
