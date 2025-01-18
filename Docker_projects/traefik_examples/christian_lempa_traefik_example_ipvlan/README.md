# Traefic with 2 backend docker websites

## Traefic docker:
- using ipvlan docker network IP: 10.1.0.122
- redirect port 80 to 443

## Example docker backends:
- using ipvlan docker network
- www.prodanov.org and prodanov.org nginx docker IP 10.1.0.133
- stabuilding.com nginx docker IP 10.1.0.134

## Setup cloudflare token
```
echo "CF_DNS_API_TOKEN='YOUR_TOKEN_HERE'" > .env
```

## Create the network if doesn't exist:
docker network create --driver bridge frontend
