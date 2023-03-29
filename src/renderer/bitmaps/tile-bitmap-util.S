.global draw_bitmap_rect, get_bitmap_pixel_addr

## draw_bitmap_rect(
##    xa[%rdi]: uint,
##    ya[%rsi]: uint,
##    xb[%rdx]: uint,
##    yb[%rcx]: uint,
##    color[%r12d]: uint,
##    bitmap_addr[%r15]: &uint[]
## )
draw_bitmap_rect:
  pushq %rdi
  pushq %rsi
  pushq %rdx
  pushq %rcx
  pushq %r12

  movq %rdi, %r13
  movq %rsi, %r14
  movq %rdi, %r8    # x
  movq %rsi, %r9    # y
  
  draw_bitmap_col:
    cmpq %rcx, %r9
    jge draw_bitmap_done

    draw_bitmap_row:
      cmpq %rdx, %r8
      jge draw_bitmap_next_row

      movq %r8, %rdi
      movq %r9, %rsi
      call get_bitmap_pixel_addr

      movl %r12d, (%rax)

      incq %r8
      jmp draw_bitmap_row

    draw_bitmap_next_row:
      movq %r13, %r8
      incq %r9
      jmp draw_bitmap_col

  draw_bitmap_done:
    popq %r12
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    ret

## get_bitmap_pixel_addr(
##   pixel_x[%rdi]: int,
##   pixel_y[%rsi]: int,
##   bitmap_addr[%r15]: &u32[]
## ) -> &u32
get_bitmap_pixel_addr:
  pushq %r13

  movq %rsi, %r13
  shlq $5, %r13
  addq %rdi, %r13
  shlq $2, %r13

  movq %r15, %rax
  addq %r13, %rax

  popq %r13
  ret
