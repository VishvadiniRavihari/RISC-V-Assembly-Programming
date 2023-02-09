.globl main

.equ N, 15

.data
V: .word 0,1,2,7,9,-8,4,25,7,5,-12,11,-2,11,17

.text
main:
    la a0,V       # load the address of array V to a0
    li s2,N       # load N to s2 register (number of elements to sort)

outer_loop:
    li t2,0         # load t2 register with 0 , the iterator
    la a0,V         # load new address of the position of V
    addi s2,s2,-1   # decrement N (number of elements to sort)

    inner_loop:
        beq s2,zero,exit_loop   # terminate from the loop when s2 becomes 0
                                # (when all elements are sorted out in the sub array)
   
        lw t0,0(a0)     # load current element to t0   V[i]
        lw t1,4(a0)     # load next element to t1      V[i+1]

        addi a0,a0,4    # increment the address to move to the next element
        addi t2,t2,1    # increment the iterator

        blt t0,t1,inner_loop   # repeat the inner_loop while current < next

        # swap and store the adjacent numbers in sorted manner
        sw t0,0(a0)     # pointed to the current position   V[i]
        sw t1,-4(a0)    # pointed to the previous position  V[i-1]

        beq t2,s2,outer_loop    # if t2 and s2 are equal move execution to outer_loop 
        bne t2,s2,inner_loop    # if not, move execution to inner_loop 

exit_loop:
    # nothing , just introduced to exit the outer_loop

ret
.end
