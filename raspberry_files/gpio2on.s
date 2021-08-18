.data
.balign 4
pin: .int 2
OUTPUT = 1
sm:
	.ascii "/home/pi/Desktop/clase/mail2on.sh\000"

.text
.global main
.extern printf
.extern wiringPiSetup
.extern digitalwrite
.extern pinMode

main: push {ip, lr}
	   bl wiringPiSetup
	   ldr r0,=pin
	   ldr r0,[r0]
	   mov r1, #OUTPUT
	   bl pinMode

	   @ digitalwrite (pin,1)
	   ldr r0,=pin
	   ldr r0,[r0]
	   mov r1, #1
	   bl digitalWrite

	   ldr r0,=sm
	   bl system
      pop {ip, pc}
