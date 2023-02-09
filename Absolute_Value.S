
.globl main

main:
    addi    t1,zero,-100         # store the minus value to register t1
    srai    t2,t1,0x1f                # store the value of integer after right shifting by 31
                                             # We'll call this value as mask
    xor     t3,t2,t1                   # store the value of (mask XOR minus integer)                          
    sub     t0,t3,t2                # substract mask from (mask XOR minus integer) and store final value in t0

    # The value stored will be the absolute value of minus integer we stored to register t1 at the beginning
    ret
.end