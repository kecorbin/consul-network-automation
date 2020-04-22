cat <<'TEMPLATE'> ./ios_acl.tpl
ip access-list extended permit_nginx_to_redis
{{range service "redis"}}
    permit tcp 172.16.1.0 0.0.0.255 host {{.Address}} eq {{.Port}} 
    {{end}}
TEMPLATE
consul-template -template ios_acl.tpl:ios.cfg -once
cat ios.cfg
rm ios.cfg

