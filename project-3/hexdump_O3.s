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
        mov     rdi, QWORD PTR stderr[rip]
        mov     esi, OFFSET FLAT:.LC0
        xor     eax, eax
        call    fprintf
.L3:
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
        xor     r13d, r13d
        mov     rbp, rsp
        call    fopen
        mov     r14, rax
        test    rax, rax
        je      .L24
.L4:
        mov     rcx, r14
        mov     edx, 16
        mov     esi, 1
        mov     rdi, rbp
        call    fread
        mov     r12, rax
        test    rax, rax
        je      .L25
        xor     eax, eax
        mov     ebx, 16
        mov     esi, r13d
        mov     edi, OFFSET FLAT:.LC3
        call    printf
        cmp     r12, rbx
        cmovbe  rbx, r12
        xor     r15d, r15d
.L6:
        movzx   esi, BYTE PTR [rbp+0+r15]
        mov     edi, OFFSET FLAT:.LC4
        xor     eax, eax
        add     r15, 1
        call    printf
        cmp     r15, rbx
        jb      .L6
        cmp     r12, 15
        ja      .L9
.L8:
        mov     edi, OFFSET FLAT:.LC5
        xor     eax, eax
        add     rbx, 1
        call    printf
        cmp     rbx, 16
        jne     .L8
.L9:
        mov     edi, 124
        mov     rbx, rbp
        lea     r15, [rbp+0+r12]
        call    putchar
.L12:
        movzx   edi, BYTE PTR [rbx]
        lea     eax, [rdi-32]
        cmp     al, 94
        jbe     .L22
        mov     edi, 46
.L22:
        call    putchar
        add     rbx, 1
        cmp     rbx, r15
        jne     .L12
        mov     edi, OFFSET FLAT:.LC6
        add     r13d, r12d
        call    puts
        jmp     .L4
.L25:
        mov     rdi, r14
        call    fclose
        xor     eax, eax
        jmp     .L1
.L24:
        mov     edi, OFFSET FLAT:.LC2
        call    perror
        jmp     .L3
