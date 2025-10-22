# Connect url
http://plex.ast:32400/web

# Before first start

## ipvlan netowork

You MUST create the network (if doesn't exsists) before to bring up the container!

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.1.0.0/24 --gateway 10.1.0.1 -o parent=enp1s0 docker_ipvlan
```

## Library volume
Create the volume for storing configs (Library) if doesn't exist:

```
docker volume create plex_library
```


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
docker compose down && sleep 3 && docker compose up -d && sleep 3 && docker compose ps
#Remove the dangling images:
docker image prune
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
