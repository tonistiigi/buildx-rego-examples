package docker

default allow = false

allow if input.local

xx_releases = load_json("xx_releases.json")

is_xx if {
    input.image
    input.image.repo == "tonistiigi/xx"
}

# other images allowed
allow if {
    input.image
    not is_xx
}

# all mutable tags allowed
valid_xx if {
    is_xx
    # not version tag
    not regex.match("^v?\\d+\\.\\d+\\.\\d+(-[\\w\\.]+)?$", input.image.tag)
}

# immutable tags need to be verified
valid_xx if {
    is_xx
    some release in xx_releases
    release.version == input.image.tag
    not release.denied
    release.sha256 == trim_prefix(input.image.checksum, "sha256:")
}

allow if valid_xx

decision := {
    "allow": allow,
}