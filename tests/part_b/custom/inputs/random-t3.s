.text
.globl _start
_start:
    la sp, stack_top
    la a0, data
    jal ra, subroutine
    sw x5, 0(a0)
    beq x0, x0, done

subroutine:
    addi sp, sp, -8
    sw ra, 4(sp)
    li x1, 8
    srai x3, x1, 3
    mv x5, x3
    lw ra, 4(sp)
    addi sp, sp, 8
    jalr x0, ra, 0

done:
    nop

.data
data:
    .word 0
stack_top:
    .space 64
