.data                  

    A: .word 0x1A2A3A4A     // 2190

    B: .word 0x1B2B3B4B     // 2194

.text

                        # Store string variables here.

.globl main             # make the main symbol globally visible.

main:

    # instructions to swap the content of A and B

    la a0,A    // load the address of A to register a0

    la a1,B    // load the address of B to register a1



    lw t0,0(a0)    // load the word at a0 to t0 register

    lw t1,0(a1)    // load the word at a1 to t1 register



    sw t1,0(a0)     // save the word at a0 (A) in t1 where the B was there before

    sw t0,0(a1)     // save the word at a1 (B) in t0 where the A was there before



   

    ret

.end