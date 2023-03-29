.global handle_bomb, bomb_x, bomb_y

.data
  bomb_x: .quad -1
  bomb_y: .quad -1

.text

handle_bomb:
  movq %rdi, bomb_x(%rip)   # move bomb coordinates into data state
  movq %rsi, bomb_y(%rip)
  jmp handle_game_lose      # call end handler
