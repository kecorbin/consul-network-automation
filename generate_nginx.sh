cat <<'TEMPLATE'> ./redis_service.tpl
user  nginx;
error_log  /var/log/nginx/error.log info;
pid        /var/run/nginx.pid;
load_module modules/ngx_stream_js_module.so;


# TCP/UDP proxy and load balancing block
#
stream {
    # Example configuration for TCP load balancing
    upstream redis_backend {
        zone redis 64k;
        {{range service "redis"}}
        server {{.Address}}:{{.Port}};
        {{end}}
    }
    match redis {
        # don't forget '\n' otherwise you'll never get response.
	      send "config get maxclients\n";
	      expect ~* "maxclients";
    }
    server {
        listen 6379;
        status_zone redis;
	      proxy_timeout 2s;
        health_check match=redis mandatory interval=20 fails=1 passes=2;
        proxy_pass redis_backend;

	  access_log /var/log/nginx/redis_access.log redis;
	  error_log /var/log/nginx/redis_error.log info;
    }
}
TEMPLATE

consul-template -template redis_service.tpl:web_service.conf -once
cat web_service.conf
rm web_service.conf
