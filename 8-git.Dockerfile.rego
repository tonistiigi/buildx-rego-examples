package docker

default allow = false


allowed_versions = [
    {"tag": "v0.26.1", "annotated": true, "sha": "abc123"}
]

is_buildkit if {
    input.git
    input.git.remote == "https://github.com/moby/buildkit.git"
}

allow if {
    not is_buildkit
}

allow if {
    is_buildkit
    some version in allowed_versions
    version.tag == input.git.tagName
    # version.annotated == input.git.annotated
    # version.sha == input.git.commit
}

decision := {
    "allow": allow,
}