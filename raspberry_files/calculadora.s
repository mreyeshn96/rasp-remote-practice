
@ --- Calculadora ----
.data

@ --- Declaracion de variables ----

@ ----------Formato de Entrada de variables -----
.align 2
scan_format:
            .asciz "%d"

@ ---------Formato de Variables de Salida -----
.align 2
out_format:
           .asciz "%d"
out_format_Resta:
                 .asciz "%d"
@ ----- Mensaje para el usuario/Captura de Datos
.align 2
prompt1:
        .asciz "     Ingrese el primer digito:"
prompt2:
        .asciz "     Ingrese el segundo digito:"
label1:
       .asciz "      1) Suma"
label2:
       .asciz "      2) Resta"
label4:
       .asciz "      3) Encender GPIO #8"
label5:
       .asciz "      4) Apagar GPIO #8"
label7:
	.asciz "      5) Encender GPIO #2"
label8:
	.asciz "      6) Apagar GPIO #2"
label9:
	.asciz "      7) Encender GPIO #21"
label10:
	.asciz "      8) Apagar GPIO #21"
label6:
	.asciz "      9) Tiempo CRON"
label3:
       .asciz "      Escriba una opcion"
fgpio0on:
       .ascii "/home/pi/Desktop/clase2/gpio0on\000"
fgpio0off:
       .ascii "/home/pi/Desktop/clase2/gpio0off\000"
fgpio2on:
       .ascii "/home/pi/Desktop/clase2/gpio2on\000"
fgpio2off:
       .ascii "/home/pi/Desktop/clase2/gpio2off\000"
fgpio29on:
       .ascii "/home/pi/Desktop/clase2/gpio21on\000"
fgpio29off:
       .ascii "/home/pi/Desktop/clase2/gpio21off\000"
limpiar:
	.ascii "/home/pi/Desktop/clase2/limpiar\000"
tiempo:
       .ascii "/home/pi/Desktop/clase2/tiempo.sh\000"
@ --- Variables de Entrada

.align 2
Numero1:
.word 0
Numero2:
.word 0
op:
.word 0
@ --- Variables de Salida
.align 2
Suma:
.word 0
Resta:
.word 0
Producto:
.word 0

@ ------ Programa Principal ------
.text
.global main

main:  push {ip, lr}

                    ldr r0,=label1
                    bl puts
                    ldr r0,=label2
                    bl puts
                    ldr r0,=label4
                    bl puts
                    ldr r0,=label5
                    bl puts
		    ldr r0,=label7
		    bl puts
		    ldr r0,=label8
		    bl puts
		    ldr r0,=label9
		    bl puts
		    ldr r0,=label10
		    bl puts
		    ldr r0,=label6
		    bl puts
                    ldr r0,=label3
                    bl puts
                    ldr r1,=op
                    ldr r0,=scan_format
                    bl scanf
                    
                    ldr r5,=op
                    ldr r1,[r5]
                    
                    cmp r1,#1
                    beq then1
                    b endif1
               then1:
                     ldr r0,=prompt1 
                     bl puts
                     ldr r1,=Numero1
                     ldr r0,=scan_format
                     bl scanf
                     
                     ldr r0,=prompt2
                     bl puts
                     ldr r1,=Numero2
                     ldr r0,=scan_format
                     bl scanf
                     
                     ldr r5,=Numero1
                     ldr r1,[r5]
                     ldr r5,=Numero2
                     ldr r2,[r5]
                     add r0,r1,r2
                     ldr r3,=Suma
                     str r0,[r3]
                    
                     ldr r9,=Suma
                     ldr r1,[r9]
                     ldr r0,=out_format
                     bl printf

                endif1:     
                    
                    cmp r1,#2
                    beq then2
                    b endif2
               then2:

                    ldr r0,=prompt1
                    bl puts
                    ldr r1,=Numero1
                    ldr r0,=scan_format
                    bl scanf

                    ldr r0,=prompt2
                    bl puts
                    ldr r1,=Numero2
                    ldr r0,=scan_format
                    bl scanf

                    @ --- Resta ----

                    ldr r5,=Numero1
                    ldr r1,[r5]
                    ldr r5,=Numero2
                    ldr r2,[r5]
                    sub r0,r1,r2
                    ldr r3,=Resta
                    str r0,[r3]

                    ldr r9,=Resta
                    ldr r1,[r9]
                    ldr r0,=out_format_Resta
                    bl printf
              endif2:

                    cmp r1,#3
                    beq then3
                    b endif3
              then3:
                    ldr r0,=fgpio0on
                    bl system
              endif3:

                    cmp r1,#4
                    beq then4
                    b endif4
              then4:
                    ldr r0,=fgpio0off
                    bl system 
              endif4:
		    cmp r1,#5
		    beq then5
		    b endif5
	      then5:
		    ldr r0,=fgpio2on
		    bl system
	      endif5:
		    cmp r1,#6
		    beq then6
		    b endif6
	      then6:
		    ldr r0,=fgpio2off
		    bl system

	      endif6:
		    cmp r1,#7
		    beq then7
		    b endif7
	      then7:
		    ldr r0,=fgpio29on
		    bl system
	      endif7:
		     cmp r1,#8
		     beq then8
		     b endif8
	      then8:
		    ldr r0,=fgpio29off
		    bl system
	      endif8:
		     cmp r1,#9
		     beq then9
		     b endif9
	      then9:
		    ldr r0,=tiempo
		    bl system
	      endif9:
	pop {ip, pc}
