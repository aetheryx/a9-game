.global handle_reset

handle_reset:
  leaq _reset_tiles(%rip), %rdi
  call generic_tile_iterator

  movb $0, is_finished(%rip)
  movq $0, start_time(%rip)
  movq $NUM_BOMBS, flags_available(%rip)

  leaq game_time(%rip), %r8
  movb $48, (%r8)
  movb $48, 1(%r8)
  movb $48, 2(%r8)

  leaq game_won(%rip), %r8
  movl $0xFF000000, (%r8)

  ret

_reset_tiles:
  call set_tile_unflagged
  call set_tile_unbomb
  call set_tile_unrevealed
  ret