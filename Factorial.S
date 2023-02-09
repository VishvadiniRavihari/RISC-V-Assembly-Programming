.globl main

.equ N, 15

.data
# define input number
input: .word 7

.bss
# define the space for output number
fact: .space 4

.text
main:
    la a1,fact          # load the output word's address to a1 register
    
    la a0,input         # load the address of input number to a0 and load it's value to t0 register
    lw t0,0(a0)
    
    add t2,t0,zero      # set the value of input number to t2 register to use it as the terminater
    li t1,1             # load number 1 to t1 register

/*  The calculation in here would be as : 7*1 >> 7*1*2 >> 7*1*2*3 >> 7*1*2*3*4 
    >> 7*1*2*3*4*5 >> 7*1*2*3*4*5*6 */
repeat:
    
    mul t0,t0,t1        # update the value at t0 by multiplying it's existing value with t1's incremented value
    addi t1,t1,1        # increment the value of t1 by 1
    bne t1,t2,repeat    # continue the loop until termination condition is satisfied (t1 == t2)

sw t0,0(a1)             # store the final value to t0 register

ret
.end
