.section .text
.global _start

_start:
    mov x0, #1          // Load 1 into register r0
    
increment_loop:
    add x0, x0, #1      // Increment x0 by 1 (x0 = x0 + 1)
    b increment_loop    // Branch back to increment_loop (unconditional jump)
