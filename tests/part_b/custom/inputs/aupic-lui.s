# Initialize t0 with LUI: Load upper immediate (0x12345 << 12)
lui t0, 0x12345        # t0 = 0x12345000

# Add lower bits with addi
addi t0, t0, 0x678     # t0 = 0x12345678

# Initialize t1 with AUIPC: PC + (offset << 12)
auipc t1, 0x0          # t1 = current PC + 0

# Add 0x1000 bytes to PC using AUIPC (offset = 1)
auipc t2, 0x1          # t2 = PC + 0x1000

# Add immediate offset at t2’s base
addi t2, t2, 0x20      # t2 = PC + 0x1000 + 0x20

# Test use: add t3 = t0 + t2 (combine LUI and AUIPC results)
add t3, t0, t2

# Edge cases:
# LUI load only upper bits, lower bits zero
lui t4, 0x0            # t4 = 0
addi t4, t4, 0x1       # t4 = 1

# AUIPC with negative offset of -4096 (0xFFFFF << 12 = -0x1000)
auipc t5, 0xFFFFF
addi t5, t5, -0x20

# Combine with addi offset
addi t5, t5, -0x20     # t5 = PC - 0x1020

# Final: Verify t0,t1,t2,t3,t4,t5 hold expected values using nop or a known place to inspect registers
nop
nop
