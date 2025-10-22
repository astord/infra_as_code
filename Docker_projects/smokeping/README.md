# https://hub.docker.com/r/linuxserver/smokeping

http://smokeping.ast
http://smokeping.ast/smokeping/

# Before first start

## ipvlan netowork

You MUST create the network (if doesn't exsists) before to bring up the container!

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.1.0.0/24 --gateway 10.1.0.1 -o parent=enp1s0 docker_ipvlan
```

## RRD data volume
Create the volume for the smokeping RRD data if doesn't exeist:

```
docker volume create smokeping_data
```


# Updates/Patching

## Check the current images

```
docker images lscr.io/linuxserver/smokeping
```

## Patching

```
docker tag lscr.io/linuxserver/smokeping:latest lscr.io/linuxserver/smokeping:vX.0  # Tag the current image
docker compose pull                                                                 # Update all images
docker compose up -d && sleep 3 && docker compose ps                                # Compose update all containers and check status
docker image prune                                                                  # remove the old dangling images
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
