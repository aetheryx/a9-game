.global handle_left_click

handle_left_click:
  call check_reset              # check if mouse coordinates are on reset button, handle reset

  cmpb $1, is_finished(%rip)    # ignore all clicks if game is finished
  je _ret

  call scale_pixel_to_tile

  call is_within_bounds
  cmpq $0, %rax
  je _ret

  call init                     # init game on first click (idempotent)

  call is_tile_revealed         # ignore revealed or flagged tiles
  cmpb $1, %al
  je _ret

  call is_tile_flagged
  cmpb $1, %al
  je _ret

  jmp handle_reveal

## check_reset()
## checks if mouse coordinates are on reset button, calls reset handler if so
check_reset:
  cmpq restart_btn_xa(%rip), %rdi
  jl _ret
  cmpq restart_btn_xb(%rip), %rdi
  jg _ret
  cmpq restart_btn_ya(%rip), %rsi
  jl _ret
  cmpq restart_btn_yb(%rip), %rsi
  jg _ret

  jmp handle_reset
