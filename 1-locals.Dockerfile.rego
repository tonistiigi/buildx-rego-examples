package docker

default allow = false

# locals are valid

allow if input.local

decision := {
    "allow": allow 
}