@ generate numbers
@
@ this function returns one random integer from 0-20


.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global generate_number
.type generate_number, %function

@ takes in no parameters
@ returns one int
generate_number:   
	mov r9, lr

	@ srand(time(0))
	mov r0, #0 @ begin to call time(0)
	bl time @ call time
	mov r1, r0 @ save time to r1
	bl srand @ use current time to make seed
	bl rand @ generate random number

	mov r1, r0
	mov r2, #21 @ the random number < 21
	udiv r0, r1, r2
	mul r0, r0, r2
	sub r0, r1, r0

	mov lr, r9
bx lr
