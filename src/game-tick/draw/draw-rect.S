## this is where i got lazy

.global draw_rect

draw_rect:
  pushq %r8
  call _DrawRectangle
  popq %r8
  ret
