package docker

default allow = false

alpine322 = "sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715"

allow if input.local

allow if {
  input.image.repo == "alpine"
  print(input.image)
  pin_image(input.image, alpine322)
}


decision := {
    "allow": allow,
}


