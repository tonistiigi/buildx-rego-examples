package docker

default localsvalid = false

# locals only valid if not release=1 , release should use Git

localsvalid if {
    not input.local
}

localsvalid if {
    not (input.env.args["release"] == "1")
}

decision := {
    "allow": localsvalid,
}