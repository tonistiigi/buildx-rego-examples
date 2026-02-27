package docker

default allow = false

allow if input.local

allow if {
    print("image:", input.image.ref)
    p := input.image.provenance
    p.completeness.parameters
    p.completeness.materials
    # print("provenance materials:", p.materials[0])
    m0 := p.materials[0]
    m0.image.hasProvenance
    m0.image.provenance.predicateType != ""
    print("material[0] repo:", m0.image.repo, "predicate:", m0.image.provenance.predicateType)
}

decision := {"allow": allow}
