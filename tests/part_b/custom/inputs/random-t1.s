# factorial_mul_overflow.s
# Computes factorial(12) and stores 64-bit result in result_low/result_high

.globl _start
_start:
    li x5, 1          # product_low = 1
    li x6, 0          # product_high = 0
    li x7, 12         # n = 12

    la x10, result_low
    la x11, result_high

loop_mul:
    beq x7, x0, done_mul

    mv x8, x7         # multiplier = loop counter

    mul x14, x5, x8
    mulhu x15, x5, x8

    mul x16, x6, x8
    mulhu x17, x6, x8

    add x5, x14, x0
    add x6, x16, x15
    mv x18, x17

    la x9, debug_area
    slli x19, x7, 4
    add x9, x9, x19
    sw x5, 0(x9)
    sw x6, 4(x9)
    sw x18, 8(x9)

    addi x7, x7, -1
    jal x0, loop_mul

done_mul:
    sw x5, 0(x10)
    sw x6, 0(x11)

halt:

.data
result_low:  .word 0
result_high: .word 0
debug_area:  .space 256    # 16 * 16 bytes
