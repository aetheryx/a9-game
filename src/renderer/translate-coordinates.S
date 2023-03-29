.global scale_tile_to_pixel, scale_pixel_to_tile

## scale_tile_to_pixel(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> pixel_x[%rdi]: uint, pixel_y[%rsi]: uint
## scales tile coordinates to pixel coordinates, to the top left pixel of the tile
## modifies inputs
scale_tile_to_pixel:
  shlq $5, %rdi
  shlq $5, %rsi

  addq $GRID_OFFSET_X, %rdi
  addq $GRID_OFFSET_Y, %rsi
  ret

## scale_pixel_to_tile(pixel_x[%rdi]: uint, pixel_y[%rsi]: uint) -> tile_x[%rdi]: uint, tile_y[%rsi]: uint
## scales pixel coordinates to tile coordinates, to the coordinates of the tile that this pixel is on
## modifies inputs
scale_pixel_to_tile:
  subq $GRID_OFFSET_X, %rdi
  subq $GRID_OFFSET_Y, %rsi

  shrq $5, %rdi
  shrq $5, %rsi

  ret
