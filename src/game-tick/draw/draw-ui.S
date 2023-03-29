## this is where i got lazy

.global draw_ui, restart_btn_xa, restart_btn_xb, restart_btn_ya, restart_btn_yb

.data
  restart_btn_xa: .quad -1
  restart_btn_xb: .quad -1
  restart_btn_ya: .quad -1
  restart_btn_yb: .quad -1

.text

restart_message:
  .asciz "RESTART"

draw_ui:
  movq $UI_PADDING, %rdi
  movq $UI_PADDING, %rsi
  movq $WINDOW_WIDTH, %rdx
  subq $UI_PADDING, %rdx
  movq $80, %rcx
  movq $0xFFC0C0C0, %r8
  call draw_rect

  movq $UI_PADDING, %rdi
  movq $UI_PADDING, %rsi
  movq $WINDOW_WIDTH, %rdx
  subq $UI_PADDING, %rdx
  subq $UI_PADDING, %rdx
  movq $5, %rcx
  movq $0xFF909090, %r8
  call draw_rect
  
  movq $WINDOW_WIDTH, %rdi
  subq $UI_PADDING, %rdi
  subq $5, %rdi
  movq $UI_PADDING, %rsi
  movq $5, %rdx
  movq $80, %rcx
  movq $0xFF909090, %r8
  call draw_rect

  // movq $WINDOW_WIDTH, %rdi
  // subq $UI_PADDING, %rdi
  // movq $TOP_OFFSET, %rsi
  // addq $UI_PADDING, %rsi
  // movq $4, %rdx
  // movq $WINDOW_HEIGHT, %rcx
  // subq %rsi, %rcx
  // subq $UI_PADDING, %rcx
  // movq $0xFF909090, %r8
  // call draw_rect

  movq $UI_PADDING, %rdi
  movq $UI_PADDING, %rsi
  movq $5, %rdx
  movq $80, %rcx
  movq $0xFF909090, %r8
  call draw_rect

  movq $UI_PADDING, %rdi
  movq $UI_PADDING, %rsi
  addq $80, %rsi
  movq $WINDOW_WIDTH, %rdx
  subq $UI_PADDING, %rdx
  subq $UI_PADDING, %rdx
  movq $5, %rcx
  movq $0xFF909090, %r8
  call draw_rect

  movq $WINDOW_WIDTH, %rdi
  shrq $1, %rdi
  subq $80, %rdi
  movq $45, %rsi
  pushq %rdi
  pushq %rsi
  movq %rdi, restart_btn_xa(%rip)
  movq %rsi, restart_btn_ya(%rip)
  movq %rdi, restart_btn_xb(%rip)
  movq %rsi, restart_btn_yb(%rip)
  movq $160, %rdx
  movq $38, %rcx
  addq %rdx, restart_btn_xb(%rip)
  addq %rcx, restart_btn_yb(%rip)
  movq $0xFF909090, %r8
  call draw_rect

  leaq restart_message(%rip), %rdi
  popq %rdx
  popq %rsi
  addq $5, %rsi
  addq $5, %rdx
  movq $30, %rcx
  movq $0xFF000000, %r8
  call _DrawText

  ret
