.enums
  | map(
    .name as $enum_name |

    "# Enum: \($enum_name)\n" +
    "# Description: \(.description)\n" + (
      .values
        | map("#define RAYLIB_\($enum_name | ascii_upcase)_\(.name) \(.value)")
        | join("\n")
    )
  )
  | join("\n\n")
