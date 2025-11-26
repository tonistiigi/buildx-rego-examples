package docker

default allow = false

# locals only valid for dockerfile and context

allow if {
    input.local.name in ["dockerfile", "context"]
}

decision := {
    "allow": allow 
}