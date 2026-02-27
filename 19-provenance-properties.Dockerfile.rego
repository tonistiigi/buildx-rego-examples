package docker

default allow = false

allow if input.local

allow if {
    provenance := input.image.provenance
      
    provenance.completeness.parameters
    provenance.completeness.materials
    sha := provenance.configSource.digest.sha1
    count(input.image.signatures) > 0
    every sig in input.image.signatures {
        # print(sig.signer.sourceRepositoryDigest, sha)
        sig.signer.sourceRepositoryDigest == sha
    }
}

decision := {"allow": allow}