# Initialize test register
addi t0, x0, 1         # t0 = 1

# Test 1: Simple JAL forward jump
jal ra, test_func      # Jump to test_func, save return address in ra

addi t0, t0, 1000      # t0 += 1000 (should execute after return)

# Test 2: JAL to another function
jal ra, test_func2     # Jump to test_func2

addi t0, t0, 100     # t0 += 10000 (should execute after return)

# Program end
jal x0, end_program    # Jump to end without saving return address

# First test function
test_func:
    addi t0, t0, 10        # t0 += 10
    addi t0, t0, 20        # t0 += 20  
    jalr x0, ra, 0         # Return to caller (jump back using ra)

# Second test function  
test_func2:
    addi t0, t0, 100       # t0 += 100
    addi t0, t0, 200       # t0 += 200
    jalr x0, ra, 0         # Return to caller

# Program termination
end_program:
    # Expected t0 value: 1 + 10 + 20 + 1000 + 100 + 200 + 10000 = 11331
    nop                    # Breakpoint - examine t0 here
    #jal x0, end_program    # Infinite loop to stop simulation
