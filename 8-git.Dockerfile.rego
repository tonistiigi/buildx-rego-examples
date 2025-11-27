package docker

default allow = false


allowed_versions = [
    {"tag": "v0.26.1", "annotated": true, "sha": "2450dcbab66bbd1074964147c326b560461663a0"},
    {"tag": "v0.26.0", "annotated": true, "sha": "5248c0074ac4e488825610a5cffc573c5baa118c"},
    {"tag": "v0.25.2", "annotated": true, "sha": "5248c0074ac4e488825610a5cffc573c5baa118c"} 
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
    version.annotated == input.git.isAnnotatedTag
    version.sha == input.git.checksum
    # merge commit by GitHub Actions
    startswith(input.git.commit.message, "Merge pull request")
    input.git.commit.committer.email == "noreply@github.com"
}

decision := {
    "allow": allow,
}