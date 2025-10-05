.text
main:
    auipc sp, 0x10000       # sp = 0x10000000
    jal ra, func            # jump to func, save return addr
    addi sp, sp, 9          # should run after return
    beq x0, x0, end

func:
    addi a0, x0, 0          # dummy op
    jalr x0, ra, 0          # return to caller

end:
    nop
