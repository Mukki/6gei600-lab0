.section .text
.global _start

_start:
    mov x0, #1
    mov x1, #2
    add x2, x0, x1
    mov x7, #1
    svc #0