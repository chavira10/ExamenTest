.data

cadena: .asciz "Resultado positivo\n"
cadenafin:

.text
.global main

main:   PUSH     {r7, lr}             /*  preservamos  reg.*/
        MOV      r0, #1                /*  salida  estándar */
        LDR      r1, =cadena          /*  cadena a enviar  */
        MOV      r2, #cadenafin -cadena      /*  longitud  */
        MOV      r7, #4                /*  seleccionamos  la*/
        SWI      #0          /*  llamada a sistema  ’write ’*/
        MOV      r0, #0                /*  devolvemos  ok    */
        POP      {r7, lr}             /*  recuperamos  reg.*/
        BX       lr                     /*  salimos  de main */
