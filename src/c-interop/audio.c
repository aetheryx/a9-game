#include "raylib.h"
#include "../constants.S"

struct Sound sounds[5];

void init_audio() {
  InitAudioDevice();
  sounds[SOUND_BOOM] = LoadSound("/Users/zain/uni/computer-organization/co-labs/boom.wav");
  sounds[SOUND_CLICK] = LoadSound("/Users/zain/uni/computer-organization/co-labs/click.wav");
  sounds[SOUND_PLACE_FLAG] = LoadSound("/Users/zain/uni/computer-organization/co-labs/place_flag.wav");
  sounds[SOUND_UNPLACE_FLAG] = LoadSound("/Users/zain/uni/computer-organization/co-labs/unplace_flag.wav");
  sounds[SOUND_WIN] = LoadSound("/Users/zain/uni/computer-organization/co-labs/win.wav");
}

void play_audio(int sound) {
  PlaySoundMulti(sounds[sound]);
}
