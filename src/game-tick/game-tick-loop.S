.global game_tick_loop

game_tick_loop:
  call _WindowShouldClose     # if window should close, jump to exit logic
  cmpq $1, %rax
  je _ret

  call poll_mouse             # handle mouse inputs
  call draw                   # draw

  jmp game_tick_loop
