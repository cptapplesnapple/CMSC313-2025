.section .data
msg:    .ascii "The double is: "
msg_len = . - msg

newline: .ascii "\n"

.section .bss
input:  .space 32
output: .space 32

.section .text
.globl _start

_start:

    # --- read input from stdin ---
    mov $0, %rax
    mov $0, %rdi
    mov $input, %rsi
    mov $32, %rdx
    syscall

    # --- convert ASCII string to integer ---
    mov $input, %rsi
    xor %rax, %rax

convert_loop:
    movzbq (%rsi), %rbx
    cmp $'0', %rbx
    jl convert_done
    cmp $'9', %rbx
    jg convert_done

    sub $'0', %rbx
    imul $10, %rax
    add %rbx, %rax

    inc %rsi
    jmp convert_loop

convert_done:

    # --- double the number ---
    add %rax, %rax

    # --- convert integer to ASCII (store backwards) ---
    mov $output, %rsi
    add $31, %rsi
    mov $0, %rcx

convert_back:
    mov $0, %rdx
    mov $10, %rbx
    div %rbx

    add $'0', %rdx
    mov %dl, (%rsi)

    dec %rsi
    inc %rcx

    test %rax, %rax
    jnz convert_back

    inc %rsi

    # Save string pointer and length to safe registers
    mov %rsi, %r8
    mov %rcx, %r9

    # --- print message ---
    mov $1, %rax
    mov $1, %rdi
    mov $msg, %rsi
    mov $msg_len, %rdx
    syscall

    # --- print number ---
    mov $1, %rax
    mov $1, %rdi
    mov %r8, %rsi
    mov %r9, %rdx
    syscall

    # --- print newline ---
    mov $1, %rax
    mov $1, %rdi
    mov $newline, %rsi
    mov $1, %rdx
    syscall

    # --- exit ---
    mov $60, %rax
    xor %rdi, %rdi
    syscall
