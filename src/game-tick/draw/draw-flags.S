.global draw_flags

.data
  flags_text: .asciz "000\n"
  flags_fmt: .asciz "%03d\n"

.text

## draw_flags()
## draws the amount of flags in the top left of the screen
draw_flags:
  leaq flags_available(%rip), %rdi    # load amount of flags available from handle-place-flag
  movq (%rdi), %rdx

  leaq flags_text(%rip), %rdi         # use sprintf to format to string
  leaq flags_fmt(%rip), %rsi
  movq $0, %rax
  call _sprintf

  leaq flags_text(%rip), %rdi
  movq $UI_PADDING, %rsi
  addq $UI_PADDING, %rsi
  addq $10, %rsi            # x
  movq $40, %rdx            # y
  movq $50, %rcx            # font size
  leaq game_won(%rip), %r8
  movl (%r8), %r8d
  call _DrawText

  ret
