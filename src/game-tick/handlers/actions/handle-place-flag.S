.global handle_place_flag, flags_available

.data
  flags_available: .quad NUM_BOMBS    # amount of flags not placed

.text

## handle_place_flag(tile_x[%rdi]: uint, tile_y[%rdi]: uint)
handle_place_flag:
  leaq flags_available(%rip), %r12
  movq (%r12), %r13

  call is_tile_flagged    # if tile is already flagged, unflag instead
  cmpb $1, %al
  je unflag_tile

  call is_tile_revealed   # if tile is revealed, skip
  cmpb $1, %al
  je _ret

  jmp flag_tile

## unflag_tile(tile_x[%rdi]: uint, tile_y[%rdi]: uint)
unflag_tile:
  incq %r13                 # increase amount of flags
  movq %r13, (%r12)
  call set_tile_unflagged   # set unflagged
  movq $SOUND_UNPLACE_FLAG, %rdi
  call _play_audio
  ret

## flag_tile(tile_x[%rdi]: uint, tile_y[%rdi]: uint)
flag_tile:
  cmpq $0, %r13       # ignore click if 0 flags left
  jle _ret

  decq %r13               # decrease amount of flags
  movq %r13, (%r12)
  call set_tile_flagged   # set flagged

  call check_game_won
  cmpq $0, %rax
  jne _ret

  movq $SOUND_PLACE_FLAG, %rdi
  call _play_audio
  ret


