.global generic_bitmap_pixel_resolver

## generic_bitmap_pixel_resolver(
##   tile_x[%rdi]: uint,
##   tile_y[%rsi]: uint,
##   bitmap_addr[%r15]: &uint[]
## ) -> pixel_color[%rdx]: uint
generic_bitmap_pixel_resolver:
  call get_bitmap_pixel_addr
  movq $0, %rdx
  movl (%rax), %edx
  ret
