package docker

default allow = false

allow if input.local

allow if {
   input.http
   print(input.http)
   sig :=artifact_attestation(input.http, "binfmt_linux-amd64.provenance.sigstore.json")
   print(sig)

   docker_github_builder_bundle(input.http, "binfmt_linux-amd64.provenance.sigstore.json", "tonistiigi/binfmt")
}

decision := {"allow": allow}
