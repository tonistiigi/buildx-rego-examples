package docker

default allow := false

allow if input.local

allow if {
  input.image.hasProvenance
}

decision := {
    "allow": allow 
}