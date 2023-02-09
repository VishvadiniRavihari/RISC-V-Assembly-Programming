.globl main

main:

    li t1, 0x7FFFFFFF                  # These 2 value combinations will result in an overflow
    li t2, 0x7FFFFFFF
    
    # li t1, 0x0000000F           # These 2 value combinations will not result in an overflow      
    # li t2, 0x0000000F                  
   

    add t0, t1, t2        # This is the instruction we want to check for overflow/underflow.
   
    slt t4,t1,zero        # set t4 register 1 if t1<0
    slt t5,t2,zero       # set t5 register 1 if t2<0
    slt t6,t0,zero       # set t6 register 1 if t0<0
    and t4,t4,t5        # store the value of (t4 AND t5) in t4
    xor t3,t4,t6          # store the value of (t4 XOR t6) in t3

    # If there is an overflow, the t3 value should be 1
    ret
.end