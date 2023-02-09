# Calculate the first 12 numbers of Fibonacci sequence and store it in an array

.equ N,12

.data      

    V:.word 0,1     // store the first 2 fibonacci values ( fib(0)= 0 & fib(1)=1 )

                           // in the array V

.text

           

.globl main

main:

    la a0,V         // load the address of V to a0

   

    # following registers are used as address pointers

        # a1 : as the pointer to current array index

        # a2 : V[i-1]   as the pointer to previous index

        # a3 : V[i-2]   as the pointer to one index before the previous index



    # following registers are used for data storing

        # t1 : i the iterator

        # t2 : fib(i-1)

        # t3 : fib(i-2)



    addi t0,zero,(N-1)                             // get the value of (12 -1) (the total count) to register t0

    addi t1,zero,1                                     // get the value of 1 (the iterator starting point)

                                                               // to register t1

    addi a1,a0,8                                    // set the pointer of current position to the 3rd

                                                             // element in V array



    repeat:

        addi t1,t1,1                                        // increment the iterator by 1

        lw t2,-4(a1)                                    // load the previous word to register t2

        lw t3,-8(a1)                                   // load the 2nd previous word to register t3

        add t2,t2,t3                                   // add the values at t2 and t3 and then store at t2

        sw t2,0(a1)                                   // save the word at t2 in a1 which is pointed to the

                                                                   //  current element to get stored

        addi a1,a1,4                                 // increment the pointer to the current position to the next

        bne t0,t1,repeat                         // repeat until pointer to the current position equals to 12



    ret

.end