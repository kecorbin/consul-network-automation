consul kv put NetworkAutomation/redis_acl_name REDIS_ACCESS > /dev/null 2>&1
cat <<'TEMPLATE'> ./redis_asa.tpl
  {{range service "redis" -}}
  access-list {{ key "NetworkAutomation/redis_acl_name@dc1" }} extended permit tcp 172.16.0.0 255.255.255.0 host {{.Address}} eq {{.Port}}
  {{end}}
TEMPLATE
consul-template -template redis_asa.tpl:asa.cfg -once

echo "Consul generated ASA config"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
cat asa.cfg
rm asa.cfg
