package docker

default allow = false

allow if not input.image

allow if input.image.labels["org.opencontainers.image.ref.name"] == "ubuntu2"

decision := {"allow": allow}