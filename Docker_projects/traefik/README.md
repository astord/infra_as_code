# Upgrade
## List all images related to pihole
```
docker images --filter=reference='traefik' --filter=reference='tecnativa/docker-socket-proxy'
```

# Tag the old images:

only for docker-socket-proxy we are with the `latest` tag. traefic is with fixed tag so there update the compose.yml file.
```
docker tag tecnativa/docker-socket-proxy:latest tecnativa/docker-socket-proxy:vX.0
```

## Pull the latest images:
docker compose pull
#Replace the running container
docker compose down
docker compose up -d

## Remove all
docker compose down --rmi all -v

## Setup cloudflare token
```
echo "CF_DNS_API_TOKEN='YOUR_TOKEN_HERE'" > .env
```

## Create the network if doesn't exist:
docker network create --driver bridge web
