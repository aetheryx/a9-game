.global draw_adjacent_bombs

.data
  adjacent_bombs_count: .skip 2, 0

.text
  adjacent_text_colors:
    .quad 0
    .quad 0xFFFF1B00    # 1
    .quad 0xFF007B00    # 2
    .quad 0xFF0000FF    # 3
    .quad 0xFF7B0700    # 4
    .quad 0xFF050B7E    # 5
    .quad 0xFF7B7B00    # 6
    .quad 0xFF1D1D1D    # 7
    .quad 0xFF7D7D7D    # 8

## draw_adjacent_bombs(tile_x[%rdi]: uint, tile_y[%rsi]: uint)
## draws, on this tile, the amount of adjacent bomb tiles
draw_adjacent_bombs:
  call count_adjacent_bombs
  cmpq $0, %rax
  je _ret

  pushq %rdi
  pushq %rsi

  call scale_tile_to_pixel
  addq $10, %rdi
  addq $4, %rsi

  leaq adjacent_text_colors(%rip), %r9
  movq (%r9, %rax, 8), %r8
  movq $30, %rcx
  movq %rsi, %rdx
  movq %rdi, %rsi
  leaq adjacent_bombs_count(%rip), %rdi
  movb $48, (%rdi)
  addb %al, (%rdi)
  call _DrawText

  popq %rsi
  popq %rdi

  ret