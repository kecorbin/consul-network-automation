#!/bin/bash
service=$1
cat << TEMPLATE > ./${service}_service.tpl
user  nginx;
error_log  /var/log/nginx/error.log info;
pid        /var/run/nginx.pid;
load_module modules/ngx_stream_js_module.so;


# TCP/UDP proxy and load balancing block
#
stream {
    # Example configuration for TCP load balancing
    upstream ${service}_backend {
        zone ${service} 64k;
        {{range service "${service}"}}
        server {{.Address}}:{{.Port}};
        {{end}}
    }
    server {
        listen 8080;
	    proxy_timeout 2s;
        health_check match=${service} mandatory interval=20 fails=1 passes=2;
        proxy_pass ${service}_backend;

	  access_log /var/log/nginx/${service}_access.log ${service};
	  error_log /var/log/nginx/${service}_error.log info;
    }
}
TEMPLATE

consul-template -template ${service}_service.tpl:${service}_service.conf -once
cat ${service}_service.conf
rm ${service}_service.tpl
rm ${service}_service.conf
