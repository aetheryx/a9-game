.global draw_timer, game_time

.data
  game_time: .asciz "000\n"
  game_time_fmt: .asciz "%03d\n"

.text

## draw_timer()
## draws the second timer on the game header
draw_timer:
  cmpb $1, is_finished(%rip)
  je _draw

  movq $0, %rdi
  call _time
  leaq start_time(%rip), %rdi
  movq (%rdi), %rsi
  subq %rsi, %rax

  cmpq $1000, %rax
  jge _draw

  leaq game_time(%rip), %rdi
  leaq game_time_fmt(%rip), %rsi
  movq %rax, %rdx
  movq $0, %rax
  call _sprintf

  _draw:
  leaq game_time(%rip), %rdi
  movq $WINDOW_WIDTH, %rsi
  subq $UI_PADDING, %rsi
  subq $UI_PADDING, %rsi
  subq $100, %rsi
  movq $40, %rdx
  movq $50, %rcx
  leaq game_won(%rip), %r8
  movl (%r8), %r8d
  call _DrawText

  ret
