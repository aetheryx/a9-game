.global count_adjacent_bombs

## count_adjacent_bombs(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> uint
## counts the amount of bombs adjacent to the given tile, not counting itself
count_adjacent_bombs:
  movq $0, %r12
  leaq count_adjacent_bomb(%rip), %rdx
  call generic_adjacent
  movq %r12, %rax
  ret

count_adjacent_bomb:
  call is_tile_bomb
  cmpb $0, %al
  je _ret

  incq %r12
  ret
