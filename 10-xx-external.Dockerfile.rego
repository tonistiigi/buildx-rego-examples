package docker

import data.hack.xx

default allow = false

allow if input.local

# other images allowed
allow if {
    input.image
    print(input.image.repo, xx.is_xx)
    not xx.is_xx
}

allow if xx.valid_xx

decision := {
    "allow": allow,
}