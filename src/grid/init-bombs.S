.global init_bombs

## init_bombs(tile_x[%r12]: uint, tile_y[%r13]: uint, amount[%r14]: uint)
init_bombs:
  cmpq $0, %r14     # exit if amount <= 0
  jle _ret

  call _rand              # tile_y = rand() % NUM_TILES_H
  movq $0, %rdx
  movq $NUM_TILES_H, %rsi
  divq %rsi
  pushq %rdx

  call _rand              # tile_w = rand() % NUM_TILES_W
  movq $0, %rdx
  movq $NUM_TILES_W, %rsi
  divq %rsi

  movq %rdx, %rdi         # retry if tile is bomb
  popq %rsi
  call is_tile_bomb
  cmpb $1, %al
  je init_bombs

  cmpq %rdi, %r12         # retry if tile is initial click
  jne _set
  cmpq %rsi, %r13
  jne _set
  
  je init_bombs

  _set:                   # set bomb, recurse with amount-1
  call set_tile_bomb
  decq %r14
  jmp init_bombs
