# Docker ipvlan IPs:

IP | hostname | URL
---|---|---
10.1.0.1  | merlin (not ipvlan) | https://merlin.ast:8443/
10.1.0.7  | cadvisor            | http://10.1.0.7:8080/containers/
10.1.0.8  | node-exporter       | http://10.1.0.8:9100/
10.1.0.9  | traefik-proxy       | http://10.1.0.9:8080/
10.1.0.11 | pihole              | https://pihole.ast/admin
10.1.0.12 | cloudflared
10.1.0.13 | prodanov-org-web
10.1.0.14 | prodanov-org-scp
10.1.0.15 | monikanova-db
10.1.0.16 | monikanova-web
10.1.0.17 | stabuilding-web
10.1.0.20 | samba
10.1.0.23 | nfs
10.1.0.24 | grafana         | http://grafana.ast:3000/
10.1.0.25 | prom-2y         | http://prom-2y.ast:9090/
10.1.0.26 | prom-1m         | http://prom-1m.ast:9090/
10.1.0.27 | alertnamager
10.1.0.28 | smokeping       | http://smokeping.ast/smokeping/
10.1.0.29 | plex            | http://plex.ast:32400/web

# Other hosts
IP | hostname | URL
---|---|---
10.1.0.4  | rpisensor pi 4 | http://rpisensor.ast:8080, http://10.1.0.4:8080/metrics, http://10.1.0.4:8080/sensors
