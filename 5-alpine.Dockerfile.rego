package docker

default allow = false

allow if input.local

supported_arch = ["amd64", "arm64"]

allow if {
  input.image
  input.image.os == "linux"
  input.image.arch in supported_arch
}

decision := {
    "allow": allow,
}