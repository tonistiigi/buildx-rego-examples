package docker

default allow = false

allowed_repos = [
   "debian"
]

allowed_hosts = [
   "download.docker.com",
   "deb.debian.org",
   "example.com"
]

allow if input.local

allow if {
   input.image
   print(input.image)
   input.image.repo in allowed_repos
}

allow if {
   input.http
   print(input.http)
   input.http.host in allowed_hosts
}

decision := {
   "allow": allow,
   "caps": {"exec.proxy": true}
}
