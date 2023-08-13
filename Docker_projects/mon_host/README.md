## ipvlan netowork

You first MUST create the network used by all docker containers bellow (if doesn't exsists).

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.1.0.0/24 --gateway 10.1.0.1 -o parent=enp1s0 docker_ipvlan
```

## Updates/Upgrades

### cadvisor update
Check the latest release version for gcr.io/cadvisor/cadvisor:v0.47.0 image from https://github.com/google/cadvisor/releases
If there is a new image:
- put the new version inside the `compose.yml` file
- `docker compose up -d --no-deps`

### node-exporter update
```
cd <project_dir>
docker tag prom/node-exporter:latest prom/node-exporter:vX.0  # tag the old image in case of revert is needed
docker compose pull                                           # pulls the latest images
docker compose up -d --no-deps                                # restarts containers with newer images

#Check and remove the old versoins:
docker images prom/node-exporter
```

## Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
