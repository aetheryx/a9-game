#define RECT(xa, ya, xb, yb, c) \
  movq $xa, %rdi; \
  movq $ya, %rsi; \
  movq $xb, %rdx; \
  movq $yb, %rcx; \
  movl $c, %r12d; \
  call draw_bitmap_rect

#define PIXEL(x, y, c) \
  movq $x, %rdi; \
  movq $y, %rsi; \
  movq $x, %rdx; incq %rdx; \
  movq $y, %rcx; incq %rcx; \
  movl $c, %r12d; \
  call draw_bitmap_rect

#define MIRRORED_PIXEL(x, y, c) \
  PIXEL(x, y, c); PIXEL(y, x, c)
