.global generic_tile_iterator

## generic_tile_iterator(
##   for_each_tile[%rdx]: &(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
## )
## executes the `for_each_tile` subroutine for every tile in the grid
generic_tile_iterator:
  movq %rdi, %rdx
  movq $0, %rdi
  movq $0, %rsi

  _col:
    cmpq $NUM_TILES_H, %rsi
    jge _ret

    _row:
      cmpq $NUM_TILES_W, %rdi
      jge _next_row

      pushq %rdi
      pushq %rsi
      pushq %rdx

      call *%rdx

      popq %rdx
      popq %rsi
      popq %rdi

      incq %rdi
      jmp _row

    _next_row:
      movq $0, %rdi
      incq %rsi
      jmp _col

