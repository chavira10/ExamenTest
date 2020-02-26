.text

  .word 0x20000000 /
  b start + 1      

start:
  mov r0, #1       
  mov r1, #2       
  add r2, r1, r0   

stop: b stop       
