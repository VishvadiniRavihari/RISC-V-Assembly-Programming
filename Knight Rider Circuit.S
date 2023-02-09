#define GPIO_SWs 0x80001400
#define GPIO_LEDs 0x80001404
#define GPIO_INOUT 0x80001408
#define SLOW 0x10000000
#define FAST 0x10000	

.globl main
main:
	/*0000 0000 0000 0000 0000 0000 0000 0000 : In here first 16 bits is allocated for switches[31:16]
	and right 16 bits are allocated for LEDs[15:0]*/
	
	# setup IO configuration
	# enable all LEDs
	li t1,0x0000ffff
	li t2,GPIO_INOUT
	sw t1,0(t2)

	/*The convention used is a1 stores led configuration and a2 stores delay*/
	li a1,0xf000	// left most 4 LEDs are intially configured
	li a2,FAST	
	// enable LEDs to ON
	li t3,GPIO_LEDs
	sw a1,0(t3)
	j delay

delay:
	add t4,zero,a1
	delay_loop:
		addi t4,t4,-1
		bne t4,zero,delay_loop
		// get the switch input
		li t2,GPIO_SWs	
		lw t1,0(t2)		
		srl t1,t1,16 # shift right by 16 bits to perform and operation next.

/*switch[0] is used to change the speed. ( slow or fast)*/
switch0:   
	andi s1,t1,1		# perform and operation with 1 and check whether switch[0] is on or off
	beq s1,zero,slow	# if 0, move slowly	
	li a2,FAST		    # else, move fast
	j switch1
slow:
	li a2,SLOW
	j switch1

/*switch[1] is used to change the direction. (right to left and left to right)*/
switch1:
	andi s2,t1,2 				# perform and operation with 2 (10) and check whether switch[1] is on or off 
	beq s2,zero,moveto_right	# if 0, move from left to right
	j moveto_left				# else, move from right to left

moveto_left:
	# shift left by 1
	# at left edge start over from right
	li t5,0xf000
	bne a1,t5,shift_left
	# start over from right 
	li a1,0xf
		// set the value to turn LED ON
	li t3,GPIO_LEDs
	sw a1,0(t3)
	j delay
/*shift left by 1 bit*/
shift_left:
	sll a1,a1,1
		// set the value to turn LED ON
	li t3,GPIO_LEDs
	sw a1,0(t3)
	j delay


/*This will perform shoft right by 1 and move back to left edge when it gets to the right corner*/
moveto_right:
	addi t5,zero,0xf		# set the configuration for that LEDs are at the right most corner
	bne a1,t5,shift_right	# if it is not equals to the current configuration, it can be further move to the right 
	# otherwise start it again from the left corner
	# set the configuration to the left most corner
	li a1,0xf000
		// set the value to turn LED ON
	li t3,GPIO_LEDs
	sw a1,0(t3)
	j delay
/*shift right by 1 bit*/
shift_right:
	srl a1,a1,1
		// set the value to turn LED ON
	li t3,GPIO_LEDs
	sw a1,0(t3)
	j delay





