.global handle_game_lose, is_finished

.data
  is_finished: .byte 0

.text

handle_game_lose:
  movb $1, is_finished(%rip)
  leaq game_won(%rip), %r8
  movl $0xFF0000FF, (%r8)
  call reveal_bombs

  movq $SOUND_BOOM, %rdi
  call _play_audio
  ret

## reveal_bombs()
## reveals every bomb tile
reveal_bombs:
  leaq handle_reveal(%rip), %rdi
  jmp generic_tile_iterator

handle_reveal:
  call is_tile_bomb
  cmpb $0, %al
  je _ret

  jmp set_tile_revealed
