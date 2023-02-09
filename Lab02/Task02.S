.globl main
main:
 
    # Write a sequence of instructions to detect overflow on unsigned variables

    addi t1, zero, 0xFFFFFFFF
    addi t2, zero, 0xFFFFFFFF
   
    add t3, zero, zero   # t3 is to hold the overflow status
   
    add t0, t1, t2        # This is the instruction we want to check for overflow.
    # Write your instruction sequence to detect overflow here.
   
    sltu t4,t0,t1
    sltu t5,t0,t2
    or t3,t4,t5

    # If there is an overflow, the t3 value should be 1
    ret
.end