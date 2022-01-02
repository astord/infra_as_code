Original idea: https://github.com/pwntr/samba-alpine-docker

Other similar projects:

- https://github.com/deftwork/samba/blob/master/Dockerfile
- https://hub.docker.com/r/twistify/anonymous-samba/dockerfile

---

TEMP

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



docker run -d --rm -it -p 445:445/tcp -v /var/lib/docker/temp_projects/samba:/config -v /srv:/shared --name samba smb
docker run -d --rm -it -p 135:135/tcp -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp -v /var/lib/docker/temp_projects/samba:/config -v /srv:/shared --name samba smb
```
