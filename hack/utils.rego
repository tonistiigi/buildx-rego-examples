package utils

match_sha256(hex) if {
  print("compare", input.image.checksum, hex)
  hex == trim_prefix(input.image.checksum, "sha256:")
}