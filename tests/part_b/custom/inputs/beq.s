addi t0, x0, 5
addi t1, x0, 3

beq x0, x0, label_take
sub t0, t0, t1 
label_take:
add t0, t0, t1

beq x0, t0, label_dont
sub t0, t0, t1 
label_dont:
add t0, t0, t1

