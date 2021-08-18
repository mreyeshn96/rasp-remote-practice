.data
.balign 4
pin: .int 0
OUTPUT = 0
sm:
	.ascii "/home/pi/Desktop/clase/mail0off.sh\000"

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

	   @ digitalwrite (pin,0)
	   ldr r0,=pin
	   ldr r0,[r0]
	   mov r1, #0
	   bl digitalWrite

	   ldr r0,=sm
	   bl system
      pop {ip, pc}
