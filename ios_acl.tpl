ip access-list extended permit_nginx_to_redis
{{range service "redis"}}
    permit tcp 172.16.1.0 0.0.0.255 host {{.Address}} eq {{.Port}} 
    {{end}}
