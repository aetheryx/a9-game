#include "raylib.h"

void PutPixel(int x, int y, Color color) {
  DrawRectangle(x, y, 1, 1, color);
}