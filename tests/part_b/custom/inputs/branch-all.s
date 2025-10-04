    addi t0, x0, 5       # t0 = 5
    addi t1, x0, 3       # t1 = 3

    # Test beq (branch if equal)
    beq x0, x0, beq_taken
    sub t0, t0, t1        # not taken path
beq_taken:
    add t0, t0, t1        # taken path

    # Test bne (branch if not equal)
    bne x0, x0, bne_dont
    sub t0, t0, t1        # taken path because x0 == x0, branch not taken, this executes
bne_dont:
    add t0, t0, t1        # path after bne

    # Test blt (branch if less than signed)
    addi t2, x0, -1       # t2 = -1
    blt t2, t1, blt_taken # -1 < 3, branch taken
    sub t0, t0, t1        # not taken path
blt_taken:
    add t0, t0, t1        # taken path

    # Test bge (branch if greater or equal signed)
    bge t1, t2, bge_taken # 3 >= -1, branch taken
    sub t0, t0, t1        # not taken path
bge_taken:
    add t0, t0, t1        # taken path

    # Test bltu (branch if less than unsigned)
    li t3, 0xffffffff      # t3 = large unsigned number (4294967295)
    bltu t2, t3, bltu_taken # -1 unsigned (large number) < 0xffffffff? false because t2 = -1 (~uint32 = 0xffffffff), branch not taken
    sub t0, t0, t1          # taken path because branch not taken
bltu_taken:
    add t0, t0, t1          # path after bltu

    # Test bgeu (branch if greater or equal unsigned)
    bgeu t3, t2, bgeu_taken # 0xffffffff >= -1 unsigned (true), branch taken
    sub t0, t0, t1
bgeu_taken:
    add t0, t0, t1

