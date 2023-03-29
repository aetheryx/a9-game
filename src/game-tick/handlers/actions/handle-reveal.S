.global handle_reveal

## handle_reveal(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
## handles a left click on a tile
handle_reveal:
  call is_tile_revealed   # ignore if tile is already revealed
  cmpb $1, %al
  je _ret

  call is_tile_bomb       # bomb handler
  cmpb $1, %al
  je handle_bomb

  jmp reveal_tile         # reveal non-bomb tile
  