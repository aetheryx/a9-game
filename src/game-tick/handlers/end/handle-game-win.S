.global check_game_won, game_won

.data
  game_won: .long 0xFF000000

.text

## check_game_won() -> bool
## checks whether the game has been won, and handles the game end logic if so
## returns whether the game has been won
check_game_won:
  movq $1, %r12           # check whether all bombs have been flagged
  leaq is_every_flagged(%rip), %rdi
  call generic_tile_iterator
  cmpq $1, %r12
  je handle_game_win

  movq $0, %rax
  ret

## is_every_flagged(tile_x[%rdi]: uint, tile_y[%rsi]: uint) -> is_flagged[%r12]: uint
is_every_flagged:
  call is_tile_bomb
  cmpb $0, %al
  je _not_bomb

  call is_tile_flagged
  cmpb $1, %al
  je _ret

  movq $0, %r12
  ret

  _not_bomb:
  call is_tile_revealed
  cmpb $1, %al
  je _ret

  movq $0, %r12
  ret

## handle_game_win()
handle_game_win:
  movb $1, is_finished(%rip)
  leaq game_won(%rip), %r14
  movl $0xFF00FF00, (%r14)
  movq $SOUND_WIN, %rdi
  call _play_audio
  movq $1, %rax
  ret
  