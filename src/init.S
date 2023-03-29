.global init, is_init, start_time, init_idempotent

.data
  start_time: .quad 0

.text

## init(mouse_x[%rdi]: uint, mouse_y[%rsi]: uint)
init:
  cmpb $0, start_time(%rip)     # return if already initialised
  jne _ret 

  pushq %rdi
  pushq %rsi

  movq %rdi, %r12
  movq %rsi, %r13
  movq $NUM_BOMBS, %r14
  call init_bombs               # init_bombs(tile_x, tile_y, amount)

  movq $0, %rdi                 # set start time
  call _time
  leaq start_time(%rip), %rdi
  movq %rax, (%rdi)

  popq %rsi
  popq %rdi
  ret
