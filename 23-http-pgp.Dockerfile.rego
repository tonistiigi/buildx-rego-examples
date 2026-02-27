package docker

default allow = false

allow if input.local

allow if {
   input.http
   print(input.http)
   verify_http_pgp_signature(input.http, "docker.release.gpg.sig", "docker.release.gpg")
}

decision := {"allow": allow}
