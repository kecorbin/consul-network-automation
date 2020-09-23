#!/bin/bash
service=$1
cat << TEMPLATE > ./${service}_ios_acl.tpl
ip access-list extended permit_${service}
{{range service "${service}"}}
    permit tcp 172.16.1.0 0.0.0.255 host {{.Address}} eq {{.Port}} 
    {{end}}
TEMPLATE

# render the template
consul-template -template ${service}_ios_acl.tpl:${service}_ios_acl.cfg -once

# display the rendered template
cat ${service}_ios_acl.cfg

# cleanup
rm ${service}_ios_acl.tpl
rm ${service}_ios_acl.cfg

