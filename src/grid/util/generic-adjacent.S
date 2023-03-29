.global generic_adjacent

## generic_adjacent(
##   tile_x[%rdi]: uint,
##   tile_y[%rsi]: uint,
##   for_each_tile[%rdx]: &(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
## )
## executes the `for_each_tile` subroutine for every tile adjacent to the given tile
generic_adjacent:
  decq %rdi
  decq %rsi
  call generic_adjacent_inner    # x-1 y-1

  incq %rsi
  call generic_adjacent_inner    # x-1 y

  incq %rsi
  call generic_adjacent_inner    # x-1 y+1

  incq %rdi
  call generic_adjacent_inner    # x y+1

  subq $2, %rsi
  call generic_adjacent_inner    # x y-1

  incq %rdi
  call generic_adjacent_inner    # x+1 y-1

  incq %rsi
  call generic_adjacent_inner    # x+1 y

  incq %rsi
  call generic_adjacent_inner    # x+1 y+1

  decq %rsi
  decq %rdi

  ret

## generic_adjacent_inner(...params(generic_adjacent))
generic_adjacent_inner:
  call is_within_bounds
  cmpq $0, %rax
  je _ret

  pushq %rdi
  pushq %rsi
  pushq %rdx

  call *%rdx

  popq %rdx
  popq %rsi
  popq %rdi

  ret
