.LC0:
        .string "Usage: %s <filename>\n"
.LC1:
        .string "rb"
.LC2:
        .string "Error opening file"
.LC3:
        .string "%08x "
.LC4:
        .string "%02x "
.LC5:
        .string "   "
.LC6:
        .string "|"
main:
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 24
        cmp     edi, 2
        je      .L2
        mov     rdx, QWORD PTR [rsi]
        mov     esi, OFFSET FLAT:.LC0
        mov     rdi, QWORD PTR stderr[rip]
        mov     eax, 0
        call    fprintf
        mov     eax, 1
.L1:
        add     rsp, 24
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        ret
.L2:
        mov     rdi, QWORD PTR [rsi+8]
        mov     esi, OFFSET FLAT:.LC1
        call    fopen
        mov     r14, rax
        mov     r13d, 0
        mov     r12, rsp
        test    rax, rax
        jne     .L4
        mov     edi, OFFSET FLAT:.LC2
        call    perror
        mov     eax, 1
        jmp     .L1
.L5:
        mov     edi, OFFSET FLAT:.LC5
        mov     eax, 0
        call    printf
.L6:
        add     rbx, 1
        cmp     rbx, 16
        je      .L17
.L7:
        cmp     rbx, rbp
        jnb     .L5
        movzx   esi, BYTE PTR [rbx+r12]
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    printf
        jmp     .L6
.L17:
        mov     edi, 124
        call    putchar
        mov     rbx, rsp
        lea     r15, [rbp+0+rbx]
        jmp     .L10
.L8:
        mov     edi, 46
        call    putchar
.L9:
        add     rbx, 1
        cmp     rbx, r15
        je      .L18
.L10:
        movzx   edi, BYTE PTR [rbx]
        lea     eax, [rdi-32]
        cmp     al, 94
        ja      .L8
        movzx   edi, dil
        call    putchar
        jmp     .L9
.L18:
        mov     edi, OFFSET FLAT:.LC6
        call    puts
        add     r13d, ebp
.L4:
        mov     rcx, r14
        mov     edx, 16
        mov     esi, 1
        mov     rdi, r12
        call    fread
        mov     rbp, rax
        test    rax, rax
        je      .L19
        mov     esi, r13d
        mov     edi, OFFSET FLAT:.LC3
        mov     eax, 0
        call    printf
        mov     ebx, 0
        jmp     .L7
.L19:
        mov     rdi, r14
        call    fclose
        mov     eax, 0
        jmp     .L1
