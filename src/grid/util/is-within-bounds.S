.global is_within_bounds

## is_within_bounds(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> bool
## returns whether tile_x, tile_y are within tile grid bounds
is_within_bounds:
  movq $0, %rax

  cmpq $NUM_TILES_W, %rdi   # x >= w
  jge _ret
  cmpq $0, %rdi             # x < 0
  jl _ret
  cmpq $NUM_TILES_H, %rsi   # y >= h
  jge _ret
  cmpq $0, %rsi             # y < 0
  jl _ret

  movq $1, %rax
  ret
