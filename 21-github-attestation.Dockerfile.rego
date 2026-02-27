package docker

default allow = false

allow if input.local

allow if {
   startswith(input.http.url, "https://github.com/cli/cli/releases/")
   # print(input.http)
   github_attestation(input.http, "cli/cli")
   # same as above
   sig := github_release_attestation(input.http)
   print(sig)
   sig.kind == "self-signed-github-repo"
   sig.signer.sourceRepositoryURI == "https://github.com/cli/cli"
}

decision := {"allow": allow}
