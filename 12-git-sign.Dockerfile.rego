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
    print("is_buildkit", is_buildkit)
    some version in allowed_versions
    version.tag == input.git.tagName
    version.annotated == input.git.isAnnotatedTag
    version.sha == input.git.checksum
    print("tag signed by", input.git.tag.pgpSignature.keyID)
    verify_git_signature(input.git.tag, "tonistiigi.asc")
    verify_git_signature(input.git.commit, "github-web-flow.gpg")

#     verify_git_signature_any(input.git, "tonistiigi.asc")
#     verify_git_signature_any(input.git, "github-web-flow.gpg")
}

decision := {
    "allow": allow,
}

# verify_git_signature_any(x, k) := true if {
#     verify_git_signature(x, k)
# }

verify_git_signature_any(git, k) := true if {
    git.commit != null
    verify_git_signature(git.commit, k)
}

verify_git_signature_any(git, k) := true if {
    git.tag != null
    verify_git_signature(git.tag, k)
}
