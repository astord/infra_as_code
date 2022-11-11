# https://github.com/ehough/docker-nfs-server

# ipvlan netowork

You MUST create the network (if doesn't exsists) before to bring up the container!

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.0.0.0/24 --gateway 10.0.0.1 -o parent=enp1s0 docker_ipvlan
```

# Updates/Patching

`vX.Y` bellow is the incremented version of the `latest` image.

```
#Tag the old image:
docker tag nfs:latest nfs:vX.0
#Build new `latest` image. The same as `docker build --no-cache -t nfs:latest .`
docker compose build --no-cache
#Replace the running container
docker compose down
docker compose up -d
```

# Bring UP via docker commands (legacy) 

<details><summary>Legaxy docker run commands</summary>

```
docker build -t nfs .
```

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.0.0.0/24 --gateway 10.0.0.1 -o parent=enp1s0 docker_ipvlan
#Run the container:
docker run -d \
  --network docker_ipvlan \
  --ip 10.0.0.19 \
  -v /data/ol_storage/HDD400:/ol                                               \
  -v /srv:/shared2                                                             \
  -v /infra/git/infra_as_code/Docker_projects/nfs/exports.file:/etc/exports:ro \
  -v /lib/modules:/lib/modules:ro \
  --privileged \
  -p 2049:2049                      \
  -p 111:111     -p 111:111/udp     \
  -p 32765:32765 -p 32765:32765/udp \
  -p 32767:32767 -p 32767:32767/udp \
  --name nfs \
  --restart=always\
  nfs:latest
```

Unable to bring the container up with (used `--privileged` isnted):

```
  --cap-add SYS_ADMIN  \
  --cap-add SYS_MODULE \
```

</details>
