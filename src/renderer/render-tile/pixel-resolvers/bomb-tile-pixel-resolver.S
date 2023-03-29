.global dynamic_bomb_tile_pixel_resolver

## intercepts the background pixels on the bomb bitmap
## turns them green if the bomb was flagged
## turns them red if it was the bomb the user just clicked on
dynamic_bomb_tile_pixel_resolver:
  call bomb_tile_pixel_resolver     # start with original logic

  cmpl $0xFFBDBDBD, %edx    # ignore non-background pixels
  jne _ret

  movq %r12, %rdi
  movq %r13, %rsi
  call scale_pixel_to_tile

  movq $0xFF00FF00, %rdx    # flag override (set to green)
  call is_tile_flagged
  cmpb $1, %al
  je _ret

  movq $0xFFBDBDBD, %rdx    # set back to original color
  cmpq %rdi, bomb_x(%rip)   # return original color if tile_x != bomb_x || tile_y != bomb_y
  jne _ret
  cmpq %rsi, bomb_y(%rip)
  jne _ret

  movq $0xFF0000FF, %rdx    # return red
  ret
