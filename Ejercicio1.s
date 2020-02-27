
 .data


 .balign 4
 message1: .asciz "Hey, type a number: "


 .balign 4
 message2: .asciz "I read the number %d\n"

 /* Format pattern for scanf */
 .balign 4
 scan_pattern : .asciz "%d"

 /* Where scanf will store the number read */
 .balign 4
 number_read: .word 0

 .balign 4
 return: .word 0

 .text



 .global main
 main:
 ldr r1, =return 
 str lr, [r1] 

 ldr r0, =message1 
 bl printf 

 ldr r0, =scan_pattern 
 ldr r1, =number_read 
 bl scanf 

 ldr r0, =message2 
 ldr r1, =number_read 
 ldr r1, [r1] 
 bl printf 

 ldr r0, =number_read 
 ldr r0, [r0] 

 ldr lr, =return 
 ldr lr, [lr] @ lr <- *lr
 bx lr 

 
 .global printf
 .global scanf
