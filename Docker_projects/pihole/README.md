Docs: https://github.com/pi-hole/docker-pi-hole

http://pihole.ast/admin/

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

**If during update problems with DNS resolution appear
change the merlin router DNS settings to some public DNS instead of pihole 10.1.0.11 DNS**

```
#Tag the old images:
docker tag pihole/pihole:latest pihole/pihole:vX.0
docker tag cloudflare/cloudflared:latest cloudflare/cloudflared:vX.0
#Pull the latest cloudflared image:
docker compose pull
#Build new `latest` image. The same as `docker build --no-cache -t pihole/pihole:latest .`
docker compose build --no-cache
#Replace the running container
docker compose down
docker compose up -d
#Remove the left public pihole image:
docker rmi pihole/pihole:vX.0
```

# Remove

To stop/destroy the project and deleta all images build:

```
docker compose down --rmi all
```
