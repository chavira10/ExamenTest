 @ BinarySearch.s
 @
 @ Demonstrates binary search on a fixed list of integers
 .data @ Data declaration section
 return: .word 0
 array: .word 2,5,11,23,47,95,191,383,767,998
 num_read: .word 0
 prompt: .asciz "\nInsert integer key (key < 0 to quit): "
 scanFMT: .asciz "%d" @ Format pattern for scanf
 echo: .asciz "\nYou entered: %d\n"
 ymsg: .asciz "\nKey was found at position %d\n"
 nmsg: .asciz "\nKey not found! a near index is: %d\n"

 .text @ Start of code section
 .global main
 main:
 ldr r1, =return @ r1 <- &return
 str lr, [r1] @ *r1 <- lr save return address

 input:
 ldr r0, =prompt @ r0 <- &prompt
 bl puts @ Print prompt

 ldr r0, =scanFMT @ r0 <- &scanFMT
 ldr r1, =num_read @ r1 <- &num_read
 bl scanf @ Call to scanf; puts value in num_read
 @echo
 ldr r0, =echo
 ldr r1, =num_read
 ldr r1, [r1]
 bl printf @ echo the key

 @check sentinal
 ldr r1, =num_read @ r1 <- &num_read
 ldr r1, [r1] @ r1 <- *r1
 cmp r1, #0 @ Look for sentinal (negative)
 blt exit @ quit if num_read is negative


 mov r6, r1 @ Put key in r6
 ldr r7, =array @ Address of array in r7

 mov r0, #0 @ r0 = low = 0 (index)
 mov r1, #9 @ r1 = high = 10 - 1

 Loop:
 cmp r1, r0 @ test high - low
 blt fail @ while( low <= high )
 @get middle
 add r3, r0, r1 @ r3 <- low + high
 mov r3, r3, ASR #1 @ r3 <- r3 / 2 = mid
 mov r8, r3 @ save index for printing
 add r5, r7, r3, LSL #2 @ r5 <- &array[4*mid]
 ldr r5, [r5] @ r5 <- array[4*mid]
 cmp r5, r6 @ test array[4*mid] - key
 blt RH @ if (array[4*mid] < key)
 bgt LH @ if (array[4*mid] > key)
 b found
 RH: add r0, r3, #1 @ low = mid + 1 (index)
 b Loop
 LH: sub r1, r3, #1 @ high = mid - 1 (index)
 b Loop
 @ found
 found:
 add r1, r8, #1 @ get index in normal count
 ldr r0, =ymsg
 bl printf @ Print yes message

 b input @ begin again

 @ not found
 fail:
 add r1, r8 , #1 @ get index in normal count
 ldr r0, =nmsg
 bl printf @ Print not found message

 b input @ try again!
 @ exit
 exit:
 ldr r1, =return @ r1 <- &return
 ldr lr, [r1] @ lr <- *r1 saved return address
 bx lr



 /* External */
 .global puts
 .global printf
 .global scanf
