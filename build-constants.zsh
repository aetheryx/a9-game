echo "# Generated with build-constants.zsh\n" > raylib-constants.S

curl https://raw.githubusercontent.com/raysan5/raylib/master/parser/output/raylib_api.json -s \
  | jq -r -f parse-constants.jq \
  >> raylib-constants.S
