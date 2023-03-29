.global init_bitmaps

init_bitmaps:
  call init_unrevealed_tile_bitmap
  call init_bomb_tile_bitmap
  call init_flagged_tile_bitmap

  ret