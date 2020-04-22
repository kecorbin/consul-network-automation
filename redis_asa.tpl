  {{range service "redis" -}}
  access-list {{ key "NetworkAutomation/redis_acl_name@dc1" }} extended permit tcp 172.16.0.0 255.255.255.0 host {{.Address}} eq {{.Port}}
  {{end}}
