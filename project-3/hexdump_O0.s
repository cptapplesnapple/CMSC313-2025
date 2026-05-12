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
        push    rbp
        mov     rbp, rsp
        sub     rsp, 80
        mov     DWORD PTR [rbp-68], edi
        mov     QWORD PTR [rbp-80], rsi
        cmp     DWORD PTR [rbp-68], 2
        je      .L2
        mov     rax, QWORD PTR [rbp-80]
        mov     rdx, QWORD PTR [rax]
        mov     rax, QWORD PTR stderr[rip]
        mov     esi, OFFSET FLAT:.LC0
        mov     rdi, rax
        mov     eax, 0
        call    fprintf
        mov     eax, 1
        jmp     .L15
.L2:
        mov     rax, QWORD PTR [rbp-80]
        add     rax, 8
        mov     rax, QWORD PTR [rax]
        mov     esi, OFFSET FLAT:.LC1
        mov     rdi, rax
        call    fopen
        mov     QWORD PTR [rbp-32], rax
        cmp     QWORD PTR [rbp-32], 0
        jne     .L4
        mov     edi, OFFSET FLAT:.LC2
        call    perror
        mov     eax, 1
        jmp     .L15
.L4:
        mov     DWORD PTR [rbp-4], 0
        jmp     .L5
.L14:
        mov     eax, DWORD PTR [rbp-4]
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC3
        mov     eax, 0
        call    printf
        mov     QWORD PTR [rbp-16], 0
        jmp     .L6
.L9:
        mov     rax, QWORD PTR [rbp-16]
        cmp     rax, QWORD PTR [rbp-40]
        jnb     .L7
        lea     rdx, [rbp-64]
        mov     rax, QWORD PTR [rbp-16]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        movzx   eax, al
        mov     esi, eax
        mov     edi, OFFSET FLAT:.LC4
        mov     eax, 0
        call    printf
        jmp     .L8
.L7:
        mov     edi, OFFSET FLAT:.LC5
        mov     eax, 0
        call    printf
.L8:
        add     QWORD PTR [rbp-16], 1
.L6:
        cmp     QWORD PTR [rbp-16], 15
        jbe     .L9
        mov     edi, 124
        call    putchar
        mov     QWORD PTR [rbp-24], 0
        jmp     .L10
.L13:
        lea     rdx, [rbp-64]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 31
        jbe     .L11
        lea     rdx, [rbp-64]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 126
        ja      .L11
        lea     rdx, [rbp-64]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        movzx   eax, al
        mov     edi, eax
        call    putchar
        jmp     .L12
.L11:
        mov     edi, 46
        call    putchar
.L12:
        add     QWORD PTR [rbp-24], 1
.L10:
        mov     rax, QWORD PTR [rbp-24]
        cmp     rax, QWORD PTR [rbp-40]
        jb      .L13
        mov     edi, OFFSET FLAT:.LC6
        call    puts
        mov     rax, QWORD PTR [rbp-40]
        add     DWORD PTR [rbp-4], eax
.L5:
        mov     rdx, QWORD PTR [rbp-32]
        lea     rax, [rbp-64]
        mov     rcx, rdx
        mov     edx, 16
        mov     esi, 1
        mov     rdi, rax
        call    fread
        mov     QWORD PTR [rbp-40], rax
        cmp     QWORD PTR [rbp-40], 0
        jne     .L14
        mov     rax, QWORD PTR [rbp-32]
        mov     rdi, rax
        call    fclose
        mov     eax, 0
.L15:
        leave
        ret
