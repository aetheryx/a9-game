# this is where i got lazy

.global set_tile_revealed, set_tile_unrevealed, is_tile_revealed, is_tile_bomb, bomb_grid, revealed_grid, is_tile_flagged, set_tile_flagged, set_tile_bomb, set_tile_unbomb, set_tile_unflagged

.data
  bomb_grid: .skip NUM_TILES, 0
  revealed_grid: .skip NUM_TILES, 0
  flagged_grid: .skip NUM_TILES, 0

.text

## is_tile_bomb(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> bool
is_tile_bomb:
  pushq %r15

  call get_tile_addr
  leaq bomb_grid(%rip), %r15
  addq %rax, %r15
  movb (%r15), %al
  popq %r15
  ret
  
## is_tile_revealed(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> bool
is_tile_revealed:
  pushq %r15

  call get_tile_addr
  leaq revealed_grid(%rip), %r15
  addq %rax, %r15
  movb (%r15), %al
  popq %r15
  ret

## is_tile_flagged(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> bool
is_tile_flagged:
  pushq %r15

  call get_tile_addr
  leaq flagged_grid(%rip), %r15
  addq %rax, %r15
  movb (%r15), %al
  popq %r15
  ret

## set_tile_flagged(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_flagged:
  leaq flagged_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $1, (%r15)
  ret

## set_tile_unflagged(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_unflagged:
  leaq flagged_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $0, (%r15)
  ret

## set_tile_unrevealed(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_unrevealed:
  leaq revealed_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $0, (%r15)
  ret

## set_tile_revealed(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_revealed:
  leaq revealed_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $1, (%r15)
  ret

## set_tile_bomb(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_bomb:
  leaq bomb_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $1, (%r15)
  ret

## set_tile_unbomb(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
set_tile_unbomb:
  leaq bomb_grid(%rip), %r15
  call get_tile_addr
  addq %rax, %r15
  movb $0, (%r15)
  ret

## get_tile_addr(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> uint
get_tile_addr:
  movq %rsi, %rax
  imulq $30, %rax
  addq %rdi, %rax
  ret
