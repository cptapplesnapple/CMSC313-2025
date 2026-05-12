# Analysis of Optimization Levels (-O0, -O1, -O3)

## Unoptimized Code (`-O0`)
The unoptimized assembly (`hexdump_O0.s`) is a direct translation of the C source code into machine instructions. 
- **Memory/Stack Usage**: This version makes heavy use of the stack to store all local variables.  Variables like the loop counter `i` and the `bytes_read` are continually read from and written to memory (e.g., `[rbp-16]`, `[rbp-40]`).
- **Control Flow**: The control flow is straightforward but provides more detail than necessary. It uses many unconditional jumps (`jmp`) and does not attempt to reorganize basic blocks to minimize branching.
- **Instruction Choice**: It uses standard instructions like `mov eax, 0` rather than the more efficient `xor eax, eax` to clear registers.

## Lightly Optimized Code (`-O1`)
The lightly optimized assembly (`hexdump_O1.s`) introduces fundamental compiler optimizations designed to reduce code size and execution time without significantly increasing compilation time.
- **Register Allocation**: The most significant change is the extensive use of callee-saved registers (`rbx`, `r12`, `r13`, `r14`, `r15`) instead of relying purely on stack memory. The stack allocation drops to just `sub rsp, 24`. 
- **Variable Storage**: Loop counters and pointers are kept in registers (like `rbx` for the inner loops), drastically reducing the number of expensive memory load/store operations.
- **Instruction Efficiency**: The compiler replaces some verbose checks with simpler instructions, such as using `test rax, rax` instead of `cmp [rbp-XX], 0` to check for null pointers or zero values.

## Heavily Optimized Code (`-O3`)
The heavily optimized assembly (`hexdump_O3.s`) turns on the compiler's most aggressive optimizations to maximize execution speed, sometimes at the expense of code size.
- **Conditional Moves (cmov)**: Instead of using a branch (`jmp`/`jxx`) to decide a value, `cmovbe` evaluates the condition and moves the data without branching. This helps avoid branch prediction penalties in the CPU pipeline.
- **Tighter Loops**: The loops (`.L6`, `.L8`, `.L12`) are constructed more efficiently. The compiler has rearranged the order of instructions to minimize the number of jumps per iteration.
- **Instruction Selection**: It consistently uses `xor reg, reg` (e.g., `xor eax, eax`) to zero out registers because it is shorter and faster to execute than moving an immediate zero.
- **Linearized Flow**: The generated code is more linearized. Unnecessary jumps present in `-O1` are removed, resulting in a cleaner fall-through structure that performs better in the processor's instruction cache.
