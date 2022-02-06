#FROM alpine:latest
#ARG SMB_PATH="/var/data"
#RUN apk update && apk upgrade && apk add --no-cache bash samba-common-tools samba tzdata && rm -rf /var/cache/apk/* \
#&& mkdir -p $SMB_PATH && chmod 777 $SMB_PATH && chown nobody:nogroup $SMB_PATH
#
#COPY smb.conf /etc/samba/smb.conf
#EXPOSE 137/udp 138/udp 139 445
##ENTRYPOINT ["smbd", "-FS"]

FROM alpine:latest
# upgrade base system and install samba and supervisord
RUN apk --no-cache upgrade && apk --no-cache add samba samba-common-tools

# create a dir for the config and the share
RUN mkdir /config /shared1 /shared2

# copy config files from project folder to get a default config going for samba and supervisord
COPY *.conf /config/

# volume mappings
VOLUME ["/config", "/shared1", "/shared2"]

# exposes samba's default ports (135 for End Point Mapper [DCE/RPC Locator Service],
# 137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp
#EXPOSE 445/tcp

ENTRYPOINT ["smbd", "-FS", "--no-process-group", "-s", "/config/smb.conf"]
