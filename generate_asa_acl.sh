#!/bin/bash
service=$1
cat << TEMPLATE > ./${service}_asa.tpl
  {{range service "$service" -}}
  access-list ${service}_acl extended permit tcp 172.16.0.0 255.255.255.0 host {{.Address}} eq {{.Port}}
  {{end}}
TEMPLATE

consul-template -template ${service}_asa.tpl:${service}_asa_acl.cfg -once

echo "Consul generated ASA config"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo ""
cat ${service}_asa_acl.cfg
rm ${service}_asa_acl.cfg
