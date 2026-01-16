package docker

default allow = false

deny_msg := ["denied by important reason"]

decision := {"allow": allow, "deny_msg": deny_msg}
