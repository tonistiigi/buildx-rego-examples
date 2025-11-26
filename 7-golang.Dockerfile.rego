package docker

default allow = false

allow if input.local

allow if {
  input.image
  input.image.repo == "golang"
  input.image.workingDir == "/go"
  some ver in input.image.env
  startswith(ver, "GOLANG_VERSION=")
  some toolchain in input.image.env
  toolchain == "GOTOOLCHAIN=local"
}

decision := {
    "allow": allow,
}