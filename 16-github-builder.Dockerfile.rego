package docker

default allow = false

allow if input.local

allow if {
  input.image
  docker_github_builder_tag(input.image, "moby/buildkit", sprintf("%s%s", ["dockerfile", input.image.tag]))
}

decision := {
    "allow": allow,
}


