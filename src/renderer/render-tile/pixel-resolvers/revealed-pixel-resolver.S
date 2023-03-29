.global revealed_tile_pixel_resolver

## revealed_tile_pixel_resolver(
##   tile_x[%rdi]: uint,
##   tile_y[%rsi]: uint,
## ) -> pixel_color[%rdx]: uint
revealed_tile_pixel_resolver:
  cmpq $3, %rdi
  jle _dark
  cmpq $3, %rsi
  jle _dark

  movq $0xFFBDBDBD, %rdx        # 0xBDBDBD for tile face
  ret

  _dark:
    movq $0xFF8C8C8C, %rdx      # 0x8C8C8C for top, left border
    ret
