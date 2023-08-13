## Traefik

This example is to show traefik with static configuration redirecting to external URL. Also this is working well with docker provider and dynamic services.
In addition there is one more docker container to secure the docker api socket needed by traefik.

https://community.traefik.io/t/setting-up-traefik-for-docker-and-external-services/14151

Security concerns:
https://medium.com/@containeroo/traefik-2-0-paranoid-about-mounting-var-run-docker-sock-22da9cb3e78c

### Networking

The traefik network is inside docker ipvpan network with a dedicated IP address. But this is not enough.
You need to create a dedicated `bridge` network in order traefic to communicate with it's backend docker services. This is created inside the compose file.

The connected services/docker containers must be connected to the ipvlan network (for general connectivity) and to that dedicated network as traefik to reach them.
This means the following block inside the compose files:

```
networks:
  web:
    external: true
  docker_ipvlan:
    driver: ipvlan
    name: docker_ipvlan
    external: true
```
