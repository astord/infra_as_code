Original idea: https://github.com/pwntr/samba-alpine-docker

Other similar projects:

- https://github.com/deftwork/samba/blob/master/Dockerfile
- https://hub.docker.com/r/twistify/anonymous-samba/dockerfile

---

<details><summary>Some example smb.conf</summary>

```
/etc/samba/smb.conf
[global]
   workgroup = WORKGROUP
   dns proxy = no
   log file = /var/log/samba/log.%m
   max log size = 1000
   syslog = 0
   panic action = /usr/share/samba/panic-action %d
   server role = standalone server
   passdb backend = tdbsam
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user
   usershare allow guests = yes
[HDD400]
  comment = public anonymous access
  path = /var/data/HDD400
  browsable =yes
  create mask = 0660
  directory mask = 0771
  writable = yes
  guest ok = yes
EOF
```

</details>


# ipvlan netowork

You MUST create the network (if doesn't exsists) before to bring up the container!

```
#Create the network (if doesn't exists):
docker network create -d ipvlan --subnet 10.0.0.0/24 --gateway 10.0.0.1 -o parent=enp1s0 docker_ipvlan
```

# Bring UP via docker commands (legacy) 

<details><summary>Legaxy docker run commands</summary>

### Default network via port mapping:

```
docker run -d --rm -it -p 135:135/tcp -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp -v /var/lib/docker/temp_projects/samba:/config -v /srv:/shared --name samba smb
```

### IPVlan network

```
#Run the container from the image:
docker run -d -it\
 --network docker_ipvlan\
 --ip 10.0.0.20\
 -v /infra/git/infra_as_code/Docker_projects/samba:/config\
 -v /data/ol_storage/HDD400:/shared1\
 -v /srv:/shared2\
 --name samba\
 --restart=always\
 smb:2.0
```

</details>
