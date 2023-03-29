.global render_generic_tile

## render_generic_tile(
##   tile_x[%rdi]: uint,
##   tile_y[%rsi]: uint,
##   pixel_resolver[%rdx]: &(
##     tile_x[%rdi]: uint,
##     tile_y[%rsi]: uint,
##     pixel_x[%r12]: uint,
##     pixel_y[%r13]: uint
##   ) -> pixel_color[%rdx]: uint 
## )
render_generic_tile:
  call scale_tile_to_pixel

  movq %rdi, %r12   # base x
  movq %rsi, %r13   # base y

  movq $0, %rdi     # x offset
  movq $0, %rsi     # y offset

  _col:
    cmpq $TILE_HEIGHT, %rsi      # end when y offset >= H
    jge _ret

    _row:
      cmpq $TILE_WIDTH, %rdi     # go to next row when x offset >= W
      jge _next_row

      pushq %rdi
      pushq %rsi
      pushq %rdx

      call *%rdx            # calls the pixel_resolver subroutine, placing the pixel in %rdx

      movq 8(%rsp), %rsi    # refresh x, y
      movq 16(%rsp), %rdi

      addq %r12, %rdi       # base x + offset x
      addq %r13, %rsi       # base y + offset y
      call _PutPixel

      popq %rdx
      popq %rsi
      popq %rdi

      incq %rdi             # x++ -> next column
      jmp _row

    _next_row:
      movq $0, %rdi         # x = 0
      incq %rsi             # y++
      jmp _col
