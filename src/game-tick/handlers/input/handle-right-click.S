.global handle_right_click

## handle_right_click(mouse_x[%rdi]: uint, mouse_y[%rsi]: uint)
## handles right clicks on tiles
handle_right_click:
  cmpb $1, is_finished(%rip)    # ignore if game is finished
  je _ret

  call scale_pixel_to_tile

  cmpq $NUM_TILES_W, %rdi       # ignore if click is not on tile grid
  jge _ret
  cmpq $0, %rdi
  jl _ret
  cmpq $NUM_TILES_H, %rsi
  jge _ret
  cmpq $0, %rsi
  jl _ret

  jmp handle_place_flag