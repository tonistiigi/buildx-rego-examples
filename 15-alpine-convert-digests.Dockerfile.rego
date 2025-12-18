package docker

default allow = false

# example of picking old known digests and converting them to updated patch release
alpine_release = {
  "3.22.0": "sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715",
  "3.22.1": "sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1",
  "3.22.2": "sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412",
  "3.23.0": "sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375",
  "3.23.2": "sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62",
}

replace_map = {
  "3.22.0": "3.22.2",
  "3.22.1": "3.22.2",
  "3.23.0": "3.23.2",
}

allow if input.local

is_alpine if input.image.repo == "alpine"


has_replacement if {
  is_alpine
  some version
  replace_map[version]
  input.image.checksum == alpine_release[version]
}

allow if {
  is_alpine
  not has_replacement
}

allow if {
  is_alpine
  some version
  replace_map[version]
  input.image.checksum == alpine_release[version]
  print("Replacing alpine digest ", input.image.checksum, " (", version, ") with ", alpine_release[replace_map[version]])
  pin_image(input.image, alpine_release[replace_map[version]])
}


decision := {
    "allow": allow,
}


