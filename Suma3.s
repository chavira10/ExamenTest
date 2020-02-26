.text

  .word 0x20000000 /
  b start + 1      

start:
  MOV r0, #1       
  MOV r1, #2       
  ADD r2, r1, r0   

stop: b stop       
