# a9-game

My submission for Bonus Assignment 9 of the Computer Organization course at the VU: Minesweeper in x86 Assembly

## Video demo
https://github.com/aetheryx/a9-game/assets/25572140/f73d2741-67b8-46be-b137-cdf20802dc75

## Implementation
The original lab assignment suggests using the [gamelib-x64](https://github.com/thegeman/gamelib-x64) project template to set up a bootable entrypoint providing graphics output and interrupt handlers for keyboard input. However, I'm on an M1 Mac, `gamelib-x64` is not compatible with Rosetta's x86 emulation, and I didn't feel like setting up a VM for development.  

So instead of using `gamelib-x64`, I used the [Raylib](https://github.com/raysan5/raylib) library with C interop. While Raylib provides many high-level concepts (shapes, 2d textures, shaders), I'm not using any of these utilities to draw pixels; I'm using Raylib with the same restrictions as [Mode 10H](https://en.wikipedia.org/wiki/INT_10H)'s `0Ch` call. The exception to this is the [audio implementation](https://github.com/aetheryx/a9-game/blob/main/src/c-interop/audio.c), which was a bonus anyway.

I did end up implementing some of these concepts myself - most notably, reusable bitmaps. I first drew the tiles in [Piskel](https://www.piskelapp.com/), so I could work on graphics visually instead of editing raw coordinates:  
<img src="https://github.com/aetheryx/a9-game/assets/25572140/abec9847-8878-42c4-a56f-fba243dff1bf" width="400px" />

Baking the bitmaps into the executable seemed like cheating, so I had to represent them in source code somehow. I'd like to think I made things reasonably bearable with [some GCC macros](https://github.com/aetheryx/a9-game/blob/main/src/renderer/bitmaps/tile-bitmap-util-macros.S). Take a look at the [flagged tile bitmap](https://github.com/aetheryx/a9-game/blob/main/src/renderer/bitmaps/tiles/flagged-tile-bitmap.S#L15-#L27) for example.  
Anyways, each of these bitmaps are pre-computed into a 32x32x4 buffer, and then drawn to the screen buffer on demand. Alongside that drawing process exists the concept of _pixel resolvers_: to prevent needing to compute every bitmap variant (e.g. red/green/grey bombs), the [tile renderer](https://github.com/aetheryx/a9-game/blob/main/src/renderer/render-tile/render-generic-tile.S) can take an address to subroutine that can override the pixel that is to be drawn, sort of like a lambda function. This way, I could render tile color palettes dynamically at runtime. See the [bomb pixel resolver](https://github.com/aetheryx/a9-game/blob/main/src/renderer/render-tile/pixel-resolvers/bomb-tile-pixel-resolver.S) as an example.

With the renderer done, the game logic was surprisingly not as difficult. The different kinds of state (revealed, bomb, or flagged) each have their own sections in memory. This is because tiles can be in more than one state (e.g. a bomb that is flagged). The [grid-state](https://github.com/aetheryx/a9-game/blob/main/src/grid/grid-state.S) module exposes some utility functions to manage the different kinds of state for a given tile.  
In terms of logic, one of the common things I had to do is **execute some code for every tile adjacent to a given tile**. This was another interesting use of a lambda subroutine: the [`generic_adjacent`](https://github.com/aetheryx/a9-game/blob/main/src/grid/util/generic-adjacent.S) function, given the coordinates of a tile, executes a given subroutine for every adjacent tile. This made [counting adjacent bombs](https://github.com/aetheryx/a9-game/blob/main/src/grid/count-adjacent-bombs.S) quite simple. The [recursive revealing algorithm](https://github.com/aetheryx/a9-game/blob/main/src/game-tick/handlers/actions/reveal-tile.S) that spreads through the grid revealing tiles on click is implemented similarly.

