
 .data

 .balign 4 
 message1: .asciz "Hey, type a number: "
 .balign 4 
 message2: .asciz "%d times 5 is %d\n"
 .balign 4 
 scan_pattern: .asciz "%d"
 .balign 4 
 number_read: .word 0
 .balign 4
 return: .word 0
 .balign 4
 return2: .word 0

 .text




 mult_by_5:
 ldr r1, =return2 
 str lr, [r1] 
 add r0, r0, r0, LSL #2 

 ldr lr, =return2 
 ldr lr, [lr] @ lr <- *lr
 bx lr 

 .global main
 main:
 ldr r1, =return 
 str lr, [r1] 
 
 ldr r0, =message1 
 bl printf 

 ldr r0, =scan_pattern
 ldr r1, =number_read @ r1 <- &number_read
 bl scanf 
 
 ldr r0, =number_read
 ldr r0, [r0] 
 bl mult_by_5

 mov r2, r0 
 ldr r1, =number_read 
 ldr r1, [r1] 
 ldr r0, =message2 
 bl printf 

 ldr lr, =return 
 ldr lr, [lr]
 bx lr 

 .global printf
 .global scanf
