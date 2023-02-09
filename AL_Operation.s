.globl main

# 3 numbers are defined as A B C words
.data
A: .word 1
B: .word 2
C: .word 3

# allocate memory space of 4 to store the sum of 3 numbers
.bss
sum: .space 4
.text

main:
# load the addresses of each variable to address registers
la a0,sum
la a1,A
la a2,B
la a3,C

# reserve space for a stack
add sp,sp,-16
# reserve saved registers to store address values in stack
sw s1, 0(sp)
sw s2, 4(sp)
sw s3, 8(sp)

# move the addresses of numbers to the stack
mv s1,a1
mv s2,a2
mv s3,a3
# register t0 is used to held the answer of sum operation
# hence, initially t0 is defined to 0
li t0,0
# load the numbers from stack to t1,t2,t3 registers
lw t1,0(s1)
lw t2,0(s2)
lw t3,0(s3)
# do the sum and store the answer in t0 register
add t0,t1,t2
add t0,t0,t3
# store the final answer in allocated memory space for variable sum
sw t0,0(a0)
 
# restore the registers of stack  
lw s1, 0(sp)
lw s2, 4(sp)
lw s3, 8(sp)
# restore the stack pointer
add sp, sp, 16

ret
.end