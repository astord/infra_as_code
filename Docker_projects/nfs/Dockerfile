FROM erichough/nfs-server:latest
RUN mkdir /ol /shared2

# volume mappings
VOLUME ["/ol", "/shared2"]
# 
EXPOSE 2049/tcp 111/tcp 111/udp 32765/tcp 32765/udp 32767/tcp 32767/udp
