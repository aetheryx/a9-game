.global draw

draw:
  call _BeginDrawing

  movq $0xFFBDBDBD, %rdi
  call _ClearBackground

  call draw_ui
  call draw_tiles
  call draw_timer
  call draw_flags

  call _EndDrawing
  ret

draw_tiles:
  leaq handle_draw(%rip), %rdi
  jmp generic_tile_iterator

  handle_draw:
    jmp tile_renderer
