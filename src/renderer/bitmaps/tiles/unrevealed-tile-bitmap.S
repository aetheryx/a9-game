#include "../tile-bitmap-util-macros.S"

.global init_unrevealed_tile_bitmap, unrevealed_tile_pixel_resolver, _init_unrevealed_tile_bitmap_reuse

.data
  unrevealed_tile_bitmap: .skip TILE_BITMAP_SIZE, 0

.text

init_unrevealed_tile_bitmap:
  leaq unrevealed_tile_bitmap(%rip), %r15

  // RECT(0, 0, 32, 32, 0xFF0000FF)     # red for debugging
_init_unrevealed_tile_bitmap_reuse:     # called by flagged tile bitmap
  RECT(0, 0, 1, 31, 0xFFF9F9F9)     # top border
  RECT(1, 0, 2, 30, 0xFFF9F9F9)
  RECT(2, 0, 3, 29, 0xFFF9F9F9)
  RECT(3, 0, 4, 28, 0xFFF9F9F9)
  RECT(4, 0, 5, 27, 0xFFF9F9F9)

  RECT(0, 0, 31, 1, 0xFFF9F9F9)     # left border
  RECT(1, 0, 30, 2, 0xFFF9F9F9)
  RECT(2, 0, 29, 3, 0xFFF9F9F9)
  RECT(3, 0, 28, 4, 0xFFF9F9F9)
  RECT(4, 0, 27, 5, 0xFFF9F9F9)

  RECT(3, 31, 32, 32, 0xFF949494)   # bottom border
  RECT(4, 30, 32, 31, 0xFF949494)
  RECT(5, 29, 32, 30, 0xFF949494)
  RECT(5, 28, 32, 29, 0xFF949494)
  RECT(5, 27, 32, 28, 0xFF949494)

  RECT(31, 3, 32, 32, 0xFF949494)   # right border
  RECT(30, 4, 32, 31, 0xFF949494)
  RECT(29, 5, 32, 30, 0xFF949494)
  RECT(28, 5, 32, 29, 0xFF949494)
  RECT(27, 5, 32, 28, 0xFF949494)

  MIRRORED_PIXEL(0, 31, 0xFFE0E0E0)   # diag 1
  MIRRORED_PIXEL(1, 30, 0xFFE0E0E0)
  MIRRORED_PIXEL(2, 29, 0xFFE0E0E0)
  MIRRORED_PIXEL(3, 28, 0xFFE0E0E0)
  MIRRORED_PIXEL(4, 27, 0xFFE0E0E0)

  MIRRORED_PIXEL(1, 31, 0xFFC7C7C7)   # diag 2
  MIRRORED_PIXEL(2, 30, 0xFFC7C7C7)
  MIRRORED_PIXEL(3, 29, 0xFFC7C7C7)
  MIRRORED_PIXEL(4, 28, 0xFFC7C7C7)

  MIRRORED_PIXEL(2, 31, 0xFFADADAD)   # diag 3
  MIRRORED_PIXEL(3, 30, 0xFFADADAD)
  MIRRORED_PIXEL(4, 29, 0xFFADADAD)

  RECT(5, 5, 27, 27, 0xFFBDBDBD)      # inner square

  ret

unrevealed_tile_pixel_resolver:
  leaq unrevealed_tile_bitmap(%rip), %r15
  jmp generic_bitmap_pixel_resolver
