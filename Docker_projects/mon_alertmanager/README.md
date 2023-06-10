## ipvlan netowork

You first MUST create the network used by all docker containers bellow (if doesn't exsists).

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.1.0.0/24 --gateway 10.1.0.1 -o parent=enp1s0 docker_ipvlan
```
## Updates/Upgrades

```
cd <project_dir>
docker tag prom/alertmanager:latest prom/alertmanager:vX.0 # tag the old image in case of revert is needed
docker compose pull                                        # pulls the latest images
docker compose down
docker compose up -d --no-deps                             # restarts containers with newer images
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
