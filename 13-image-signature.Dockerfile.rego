package docker

default allow = false

allow if input.local

allow if {
  input.image
  input.image.hasProvenance
  some sig in input.image.signatures
  valid_github_builder_signature(sig)
}

valid_github_builder_signature(sig) if {
    # missing source repository check
    # missing bundle v0.3 check
    sig.signer.certificateIssuer == "CN=sigstore-intermediate,O=sigstore.dev"
    sig.signer.issuer == "https://token.actions.githubusercontent.com"
    startswith(sig.signer.subjectAlternativeName, "https://github.com/docker/github-builder-experimental/.github/workflows/")
    startswith(sig.signer.buildSignerURI, "https://github.com/docker/github-builder-experimental/.github/workflows/")
    sig.signer.runnerEnvironment == "github-hosted"
    sig.signer.buildTrigger == "workflow_dispatch"
    startswith(sig.signer.sourceRepositoryURI, "https://github.com/")
    count(sig.timestamps) > 0
}

decision := {
    "allow": allow,
}


