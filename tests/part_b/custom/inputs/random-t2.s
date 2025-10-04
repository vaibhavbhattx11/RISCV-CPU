# mem_and_signext.s
# Tests loads/stores and sign extension.

.globl _start
_start:
    la x1, mem_base

    # Store test patterns
    li x2, -1
    sw x2, 0(x1)          # store word -1

    li x3, 0x7F
    sb x3, 4(x1)          # store byte 0x7F

    li x4, -128
    sb x4, 5(x1)          # store byte 0x80

    li x5, 0x1234
    sh x5, 6(x1)          # store halfword 0x1234

    li x6, -12345
    sh x6, 8(x1)          # store halfword negative

    # Load them back to test sign extension
    lb x10, 4(x1)         # expect 0x0000007F
    lb x11, 5(x1)         # expect 0xFFFFFF80
    lh x12, 6(x1)         # expect 0x00001234
    lh x13, 8(x1)         # expect -12345
    lw x14, 0(x1)         # expect 0xFFFFFFFF

    la x15, results
    sw x10, 0(x15)
    sw x11, 4(x15)
    sw x12, 8(x15)
    sw x13, 12(x15)
    sw x14, 16(x15)

    # slt vs sltu tests
    li x20, -1
    li x21, 1
    slt x22, x20, x21     # signed: expect 1
    sltu x23, x20, x21    # unsigned: expect 0
    sw x22, 20(x15)
    sw x23, 24(x15)

    # Branch test
    li x30, 5
    li x31, 7
    blt x30, x31, branch_ok
    li x30, 999           # should not execute
branch_ok:
    sw x30, 28(x15)

    # Program ends naturally here

.data
mem_base:
    .space 64
results:
    .word 0,0,0,0,0,0,0,0
