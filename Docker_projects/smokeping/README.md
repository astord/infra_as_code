# https://hub.docker.com/r/linuxserver/smokeping

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

```
docker-compose pull   # Update all images
docker-compose up -d  # Compose update all containers
docker image prune    # remove the old dangling images
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
