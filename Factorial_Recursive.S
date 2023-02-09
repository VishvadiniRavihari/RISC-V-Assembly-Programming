.globl main
# allocate memory space of 4 to store the final answer
.bss
answer: .space 4
.text  

factorial:      
    # reserve space for a stack
    addi  sp, sp, -8
    # save the return address in the stack    
    sw ra, 0(sp)    

    # base case
    # branch to base_case_return if value in a0 = 0 or 1.
    li t1, 2
    blt a1, t1, base_case_return
   
    # store the number n in a0 ad decrement n to set it (n-1)
    sw a1, 4(sp)  
    addi a1, a1, -1
    # jump to fact to loop with n-1
    jal factorial      

    # bring n to register t0 from the stack and do the multiplication          
    lw t1, 4(sp)    # t1 <- n
    mul a2, t1, a2  # a1 <- n * fact(n-1)
    # jump to restore the space back to memory
    j function_return
base_case_return:
    # since 0! =1!=1, load a1 with 1
    li a2, 1
function_return:
    # restore the space reserved for return address
    lw ra, 0(sp)  
    # restore the stack pointer
    addi sp, sp, 8  
    ret        

main:
# load a0 with the number we need to calulate factorial
li a1,7
# load the address of ans memory loc. to a2
la a3,answer

# reserve space for a stack and return address
add sp,sp,-16
sw ra,0(sp)

# jump to factorial process
jal factoral

# store the final answer in allocated memory space for variable answer
sw a2,0(a3)
# release the reserved space back to memory
lw ra,0(sp)
add sp,sp,16
ret
.end