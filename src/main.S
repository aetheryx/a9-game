.text
  window_name: .asciz "Minesweeper"
  print_seed: .asciz "\n\nSEED = %d\n\n\n"

.global _main

_main:
  pushq %rbp
  movq %rsp, %rbp

  movq $0, %rdi     # initialise rand seed
  call _time
  movq %rax, %rdi
  call _srand

  movq $WINDOW_WIDTH, %rdi          # window width
  movq $WINDOW_HEIGHT, %rsi         # window height
  leaq window_name(%rip), %rdx
  call _InitWindow

  movq $90, %rdi                    # fps
  call _SetTargetFPS

  call init_bitmaps
  call _init_audio

  call game_tick_loop

  movq $0, %rdi
  call _exit
