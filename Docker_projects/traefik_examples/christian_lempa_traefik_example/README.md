# Christian Lempa example
https://www.youtube.com/watch?v=-hfejNXqOzA

- Traefic with TLS certificate resolvers using Cloudflare token

Added 2 nginx docker clients for the following urls:
- prodanov.org
- stabuilding.com

## Setup cloudflare token
```
echo "CF_DNS_API_TOKEN='YOUR_TOKEN_HERE'" > .env
```

## Create the docker network if doesn't exist:
docker network create --driver bridge frontend
