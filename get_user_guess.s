@ get user guess
@ 
@ this function takes in user input and returns it

.cpu cortex-a53
.fpu neon-fp-armv8

.data
output1: .asciz "Please enter a guess (1-20): "

input1: .word 0
inputformat: .asciz "%d"

.text
.align 2
.global get_user_guess
.type get_user_guess, %function

get_user_guess:           
	mov r8, lr

	@ print out statement
    ldr r0, =output1
    bl printf
    
    @ take user input
    ldr r0, =inputformat @ pass in format
    ldr r1, =input1 @ pass in user input
    bl scanf
    ldr r1, =input1
    ldr r1, [r1] @ save user input
    
    mov r0, r1 @ return user input

    mov lr, r8
bx lr
