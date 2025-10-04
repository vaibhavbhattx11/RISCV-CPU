# Minimal test to reproduce the memory overwrite bug
# Only a few instructions

.globl _start
_start:
    li x1, 0x100        # base pointer

    # Store bytes
    li t0, 0x7F
    sb t0, 0(x1)        # store 0x7F at offset 0

    li t1, -128
    lw t0, 0(x1)
    sb t1, 1(x1)        # store 0x80 at offset 1
    lw t0, 0(x1)
    # Load bytes back
    lb t0, 0(x1)        # t0 = 0x7F
    lb t1, 1(x1)        # t1 = 0xFFFFFF80

    # Overlapping store triggers bug
    li t2, 0x12345678
    sw t2, 0(x1)        # overwrite first 4 bytes

    # Load bytes again to observe the corrupted value
    lb t0, 0(x1)        # t0 = ?? (should be 0x78, bug: 0x34 in your CPU)
    lb t1, 1(x1)        # t1 = ?? (should be 0x56, bug: 0x34 in your CPU)