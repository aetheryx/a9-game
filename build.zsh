setopt +o nullglob
rm -rf .build/*

for file in ./a9-game/**/*.S; do
	gcc -g -c \
    --include ./a9-game/raylib-constants.S \
    --include ./a9-game/src/constants.S \
    $file \
    -o ".build/a9-${file:t:s/.S/.o}" \
    || exit 1
done

gcc \
	`pkg-config --libs --cflags raylib` \
	.build/a9-*.o \
	./a9-game/**/*.c \
	-o .build/bin || exit 1
