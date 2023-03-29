#include "../tile-bitmap-util-macros.S"

.global init_bomb_tile_bitmap, bomb_tile_pixel_resolver

.data
  bomb_tile_bitmap: .skip TILE_BITMAP_SIZE, 0

.text

init_bomb_tile_bitmap:
  leaq bomb_tile_bitmap(%rip), %r15

  RECT(0, 0, 32, 32, 0xFFBDBDBD)  # tile base
  RECT(0, 0, 4, 32, 0xFF8C8C8C)   # tile shadow
  RECT(0, 0, 32, 4, 0xFF8C8C8C)

  RECT(10, 10, 26, 26, 0xFF000000)  # mine (block)

  RECT(6, 17, 30, 19, 0xFF000000)   # horizontal line
  RECT(17, 6, 19, 30, 0xFF000000)   # vertical line

  RECT(10, 12, 12, 14, 0xFFBDBDBD)  # corners
  RECT(12, 10, 14, 12, 0xFFBDBDBD)

  RECT(10, 22, 12, 24, 0xFFBDBDBD)   
  RECT(12, 24, 14, 26, 0xFFBDBDBD)

  RECT(22, 10, 24, 12, 0xFFBDBDBD)   
  RECT(24, 12, 26, 14, 0xFFBDBDBD)

  RECT(22, 24, 24, 26, 0xFFBDBDBD)   
  RECT(24, 22, 26, 24, 0xFFBDBDBD)

  RECT(14, 14, 17, 17, 0xFFFFFFFF)

  ret

bomb_tile_pixel_resolver:
  leaq bomb_tile_bitmap(%rip), %r15
  jmp generic_bitmap_pixel_resolver

