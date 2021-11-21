@ main function
@
@ drives function calls

.cpu cortex-a53
.fpu neon-fp-armv8

.data
outputHIGH: .asciz "Too high, guess again.\n\n"
outputLOW: .asciz "Too low, guess again. \n\n"
outputLOSE: .asciz "You lose! The number was %d.\n\n"
outputWIN: .asciz "You win! The number was %d.\n\n"
outputNEWLINE: .asciz "\n"

.text
.align 2
.global main
.type main, %function

@ generates a number
@ passes number to user_guess
main:
	mov r10, lr
	
	bl generate_number @ saves to r0
	mov r4, r0 @ store generated number into r4

	mov r5, #0 @ r5 = i = 0
	LOOP: @ for(int i = 0; i <= 3; i++)
		@ only take user input 3 times
		cmp r5, #3
		bge LOSE

		add r5, r5, #1

		@ save user input
		bl get_user_guess @saves to r0
		mov r6, r0 @ stores user input into r6
		ldr r0, =outputNEWLINE
		bl printf @ print new line for formatting
		
		cmp r6, r4
		beq WIN @ r6 == r4
				
		@ only allow "Too high" or "Too low" to be printed 2 times
		cmp r5, #3
		bge LOSE
		
		@ print out "Too high" or "Too low"
		cmp r6, r4
		blt LOW @ r6 < r4
		bgt HIGH @ r6 > r4
	LOW:
		ldr r0, =outputLOW
		bl printf

		b LOOP
	HIGH:
		ldr r0, =outputHIGH
		bl printf

		b LOOP
	LOSE:
		mov r1, r4
		ldr r0, =outputLOSE
		bl printf

		b FINISH
	WIN:
		mov r1, r4
		ldr r0, =outputWIN
		bl printf
		
		b FINISH
	FINISH:
	mov lr, r10
bx lr
