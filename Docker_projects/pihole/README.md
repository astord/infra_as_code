Docs: https://github.com/pi-hole/docker-pi-hole

---

# ipvlan netowork

You MUST create the network (if doesn't exsists) before to bring up the container!

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.1.0.0/24 --gateway 10.1.0.1 -o parent=enp1s0 docker_ipvlan
```

# Updates/Patching

**If you have custom black/whitelists you need to backup/restore them :exclamation:**

Backup/restore is done from web interface: http://pihole.ast/admin/settings.php?tab=teleporter

`vX.Y` bellow is the incremented version of the `latest` image.

```
#Tag the old image:
docker tag pihole:latest pihole:vX.0
#Build new `latest` image. The same as `docker build --no-cache -t pihole:latest .`
docker compose build --no-cache
#Replace the running container
docker compose down
docker compose up -d
#Remove the left public pihole image:
docker rmi pihole/pihole
```

# Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
