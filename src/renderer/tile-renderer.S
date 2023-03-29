.global tile_renderer

## tile_renderer(tile_x[%rdi]: int, tile_y[%rsi]: int)
## handles the rendering of all tiles, by checking grid state
## and passing the appropriate pixel resolver to render_generic_tile
tile_renderer:
  call is_tile_flagged
  cmpb $1, %al
  je _render_flagged

  call is_tile_revealed
  cmpb $0, %al
  je _render_unrevealed

  call is_tile_bomb
  cmpb $1, %al
  je _render_bomb

  jmp _render_revealed

##
_render_unrevealed:
  leaq unrevealed_tile_pixel_resolver(%rip), %rdx
  jmp _call_render

##
_render_revealed:
  leaq revealed_tile_pixel_resolver(%rip), %rdx
  call _call_render
  call draw_adjacent_bombs
  ret

##
_render_flagged:
  call is_tile_bomb
  cmpb $0, %al
  je _render_flagged_inner

  call is_tile_revealed
  cmpb $0, %al
  je _render_flagged_inner

  jmp _render_bomb

  _render_flagged_inner:
  leaq flagged_tile_pixel_resolver(%rip), %rdx
  jmp _call_render

##
_render_bomb:
  leaq dynamic_bomb_tile_pixel_resolver(%rip), %rdx
  jmp _call_render

## 
_call_render:
  pushq %rdi
  pushq %rsi
  call render_generic_tile
  popq %rsi
  popq %rdi
  ret

