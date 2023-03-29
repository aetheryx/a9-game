.global reveal_tile

## reveal_tile(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> void
## reveals this tile and recursively reveals adjacent tiles, stopping
## at tiles that have any adjacent bombs
reveal_tile:
  call set_tile_revealed
  call reveal_adjacent_tiles
  call check_game_won

  movq $SOUND_CLICK, %rdi
  call _play_audio
  ret

reveal_adjacent_tiles:
  call count_adjacent_bombs       # bail if no adjacent bombs
  cmpq $0, %rax
  jne _ret

  leaq reveal_inner(%rip), %rdx
  call generic_adjacent           # run reveal_inner for all adjacent mines
  ret

reveal_inner:
  call is_tile_revealed         # bail if already revealed
  cmpb $1, %al
  je _ret

  call set_tile_revealed        # reveal
  call reveal_adjacent_tiles    # recurse reveal_adjacent_tiles for this adjacent tile
  ret
