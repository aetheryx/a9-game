setopt +o nullglob
rm -rf .build
mkdir .build

for file in ./**/*.S; do
  gcc -g -c \
    --include ./raylib-constants.S \
    --include ./src/constants.S \
    $file \
    -o ".build/a9-${file:t:s/.S/.o}" \
    || exit 1
done

gcc \
  `pkg-config --libs --cflags raylib` \
  .build/a9-*.o \
  ./src/c-interop/**/*.c \
  -o .build/bin || exit 1
