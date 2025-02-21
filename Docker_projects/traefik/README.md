## Upgrade
docker compose pull
docker compose up -d

## Remove all
docker compose down --rmi all -v

## Setup cloudflare token
```
echo "CF_DNS_API_TOKEN='YOUR_TOKEN_HERE'" > .env
```

## Create the network if doesn't exist:
docker network create --driver bridge web
