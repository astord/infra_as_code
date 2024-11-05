# Connect url
http://plex.ast:32400/web

# Updates/Patching

## Check the current images

```
docker images lscr.io/linuxserver/plex
```

## Patching

```
#Tag the old image:
docker tag lscr.io/linuxserver/plex:latest lscr.io/linuxserver/plex:vX.0
#pull the `latest` image.
docker compose pull
#Replace the running container
docker compose down
docker compose up -d
#Remove the dangling images:
docker image prune
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
