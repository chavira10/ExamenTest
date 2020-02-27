
 .data 
 return: .word 0
 array: .word 2,5,11,23,47,95,191,383,767,998
 num_read: .word 0
 prompt: .asciz "\nInsert integer key (key < 0 to quit): "
 scanFMT: .asciz "%d" 
 echo: .asciz "\nYou entered: %d\n"
 ymsg: .asciz "\nKey was found at position %d\n"
 nmsg: .asciz "\nKey not found! a near index is: %d\n"

 .text 
 .global main
 main:
 ldr r1, =return 
 str lr, [r1] 

 input:
 ldr r0, =prompt 
 bl puts 

 ldr r0, =scanFMT 
 ldr r1, =num_read 
 bl scanf 
 
 ldr r0, =echo
 ldr r1, =num_read
 ldr r1, [r1]
 bl printf

 
 ldr r1, =num_read 
 ldr r1, [r1] 
 cmp r1, #0 
 blt exit 


 mov r6, r1 
 ldr r7, =array 

 mov r0, #0 
 mov r1, #9 

 Loop:
 cmp r1, r0 
 blt fail 
 @get middle
 add r3, r0, r1 
 mov r3, r3, ASR #1 
 mov r8, r3
 add r5, r7, r3, LSL #2 
 ldr r5, [r5] 
 cmp r5, r6 
 blt RH 
 bgt LH
 b found
 RH: add r0, r3, #1 
 b Loop
 LH: sub r1, r3, #1 
 b Loop
 
 found:
 add r1, r8, #1 
 ldr r0, =ymsg
 bl printf 

 b input 


 fail:
 add r1, r8 , #1 
 ldr r0, =nmsg
 bl printf 

 b input 

 exit:
 ldr r1, =return 
 ldr lr, [r1] 
 bx lr


 .global puts
 .global printf
 .global scanf
