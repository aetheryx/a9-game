#include "../tile-bitmap-util-macros.S"

.global init_flagged_tile_bitmap, flagged_tile_pixel_resolver

.data
  flagged_tile_bitmap: .skip TILE_BITMAP_SIZE, 0

.text

init_flagged_tile_bitmap:
  leaq flagged_tile_bitmap(%rip), %r15

  call _init_unrevealed_tile_bitmap_reuse

  RECT(10, 21, 24, 24, 0xFF000000)    # flag base
  RECT(12, 20, 22, 21, 0xFF000000)
  RECT(13, 19, 21, 20, 0xFF000000)

  RECT(17, 16, 19, 19, 0xFF000000)    # flag stick
  PIXEL(18, 8, 0xFF949494)

  RECT(16, 9, 19, 16, 0xFF0000FF)    # flag
  RECT(13, 10, 19, 15, 0xFF0000FF)
  RECT(13, 10, 19, 15, 0xFF0000FF)
  RECT(11, 11, 19, 14, 0xFF0000FF)
  PIXEL(10, 12, 0xFF0000FF)
  PIXEL(15, 15, 0xFF0000FF)

  ret

flagged_tile_pixel_resolver:
  leaq flagged_tile_bitmap(%rip), %r15
  jmp generic_bitmap_pixel_resolver
