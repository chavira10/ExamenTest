.text
.global main
main:

ldr r7, =return 
str lr, [r7] 
mov r6, #0 
ldr r4, =array 

input:
ldr r0, =prompt
bl puts
ldr r0, =scanFMT 
ldr r1, =number 
bl scanf 
ldr r1, =number
ldr r1, [r1]
cmp r1, #0 
blt isort 
add r0, r4, r6, LSL #2 
str r1, [r0] 
add r6, r6, #1 
b input

isort:
mov r0, r4 
mov r1, r6 
mov r2, #1 
iloop: 
cmp r2, r1 
bge iloopend 
add r10, r0, r2, LSL #2
ldr r10, [r10] 
sub r3, r2, #1 
jloop: 
cmp r3, #0 
blt jloopend
add r9, r0, r3, LSL #2 @ r9 <- &array[4*j]
ldr r9, [r9] 
cmp r10, r9 
bge jloopend
add r8, r0, r3, LSL #2
add r8, r8, #4 
str r9, [r8] 
sub r3, r3, #1 
b jloop

jloopend:
add r3, r3, #1 
add r8, r0, r3, LSL #2 
str r10, [r8] 
add r2, r2, #1 
b iloop

iloopend:

output:
ldr r0, =result
bl puts
mov r5, #0 
ploop: cmp r6, r5
ble exit 
add r3, r4, r5, LSL #2 
ldr r1, [r3] 
ldr r0, =printFMT 
bl printf
add r5, r5, #1
b ploop

exit:
mov r0, r6 
ldr r1, =return 
ldr lr, [r1] 
bx lr

.data
number: .word 0 
array: .space 100 
return: .word 0 
prompt: .asciz "Input a positive integer (negative to quit): "
result: .asciz "Sorted, those integers are: \n"
scanFMT: .asciz "%d"
printFMT: .asciz " %d\n"

.global printf
.global scanf
.global puts
