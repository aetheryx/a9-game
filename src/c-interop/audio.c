#include "raylib.h"
#include "../constants.S"

struct Sound sounds[5];

void init_audio() {
  InitAudioDevice();
  sounds[SOUND_BOOM] = LoadSound("./audio_assets/boom.wav");
  sounds[SOUND_CLICK] = LoadSound("./audio_assets/click.wav");
  sounds[SOUND_PLACE_FLAG] = LoadSound("./audio_assets/place_flag.wav");
  sounds[SOUND_UNPLACE_FLAG] = LoadSound("./audio_assets/unplace_flag.wav");
  sounds[SOUND_WIN] = LoadSound("./audio_assets/win.wav");
}

void play_audio(int sound) {
  PlaySound(sounds[sound]);
}
