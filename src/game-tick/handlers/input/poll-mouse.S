.global poll_mouse

## poll_mouse()
## polls mouse state every tick and executes other
## subroutines accordingly
poll_mouse:
  movq $RAYLIB_MOUSEBUTTON_MOUSE_BUTTON_LEFT, %rdi
  call _IsMouseButtonPressed
  cmpb $0, %al
  je check_right

  call get_mouse_coordinates
  call handle_left_click

  check_right:
  movq $RAYLIB_MOUSEBUTTON_MOUSE_BUTTON_RIGHT, %rdi
  call _IsMouseButtonPressed
  cmpb $0, %al
  je _ret

  call get_mouse_coordinates
  call handle_right_click
  ret

## get_mouse_coordinates() -> mouse_x[%rdi]: uint, mouse_y[%rsi]: uint
get_mouse_coordinates:
  call _GetMouseX
  pushq %rax
  call _GetMouseY
  movq %rax, %rsi
  popq %rdi
  ret