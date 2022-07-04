# infra_as_code
Docker Vagrant Terraform

# Docker

## Bring UP via `docker compose`

### Bring UP the container in background (`-d`) mode

- If the image (`image:` section from `compose.yaml`) is not created yet, docker will build it then will run a container from it.
- If the image (`image:` section from `compose.yaml`) is already present, docker will just bring a container from it.

```
#execute in the folder where is the compose.yaml
docker compose up -d
```

### Bring STOP/START  the container

```
#execute in the folder where is the compose.yaml
docker compose stop
docker compose start
```

### Bring DOWN the container (also to remove the container)

```
#execute in the folder where is the compose.yaml
docker compose down
```

### Bring DOWN the container, removes the container and remove the image

```
#execute in the folder where is the compose.yaml
docker compose down --rmi all
```

### Check the status of the container via compose

```
#execute in the folder where is the compose.yaml
docker compose ls
```

## Network examples

- ipvlan network:

```
docker network create -d ipvlan --subnet 10.0.0.0/24 --gateway 10.0.0.1 -o parent=enp1s0 docker_ipvlan
```
