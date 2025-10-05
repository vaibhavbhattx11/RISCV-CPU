# fibonacci_jumps_and_pc_relative_fixed.s
# Generates Fibonacci numbers, computes checksum, and tests jal/jalr.
# Aligned memory access only. Does not modify sp (x2). Ends cleanly.

    .globl _start
    .text

_start:
    li x10, 16              # N = 16
    la x11, fib_array        # base pointer (aligned)

    # fib[0] = 0, fib[1] = 1
    li x12, 0
    sw x12, 0(x11)
    li x12, 1
    sw x12, 4(x11)

    li x13, 2               # i = 2

loop_fib:
    bge x13, x10, fib_done

    slli x15, x13, 2        # offset = i * 4 (word aligned)
    add x15, x11, x15

    addi x16, x15, -4       # fib[i-1] address
    lw x17, 0(x16)
    addi x18, x16, -4       # fib[i-2] address
    lw x19, 0(x18)

    add x20, x17, x19       # fib[i] = fib[i-1] + fib[i-2]
    sw x20, 0(x15)

    addi x13, x13, 1
    jal x0, loop_fib

fib_done:
    # checksum = sum(fib[0..N-1])
    li x21, 0
    li x26, 0
sum_loop:
    bge x26, x10, sum_done
    slli x27, x26, 2
    add x27, x11, x27
    lw x28, 0(x27)
    add x21, x21, x28
    addi x26, x26, 1
    jal x0, sum_loop

sum_done:
    la x29, fib_checksum
    sw x21, 0(x29)

    # Call subroutine (no stack usage)
    mv a0, x29
    jal ra, shift_right_by_3

    # store returned value (x5)
    sw x5, 0(x29)

    nop                     # graceful end


# Subroutine: shift_right_by_3
# Input: a0 = &fib_checksum
# Output: x5 = shifted value
shift_right_by_3:
    lw x1, 0(a0)            # aligned access
    srai x2, x1, 3
    mv x5, x2
    jalr x0, ra, 0


    .data
    .align 4
fib_array:
    # 32 words (aligned, all 4-byte multiples)
    .space 128              # 32 * 4 bytes

fib_checksum:
    .word 0
