addi t1, x0, 1000
addi t2, x0, 1023
sb t2, 0(t1)
sh t2, 4(t1)
sw t2, 8(t1)
lb t0, 0(t1)
lh t0, 0(t1)
lw t0, 0(t1)
lb t0, 4(t1)
lh t0, 4(t1)
lw t0, 4(t1)
lb t0, 8(t1)
lh t0, 8(t1)
lw t0, 8(t1)