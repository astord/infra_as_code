FROM pihole/pihole:latest
# Disable rate limit
RUN echo 'RATE_LIMIT=0/0' >> /etc/pihole/pihole-FTL.conf
# Add addresses to whitelist
RUN pihole -w s.youtube.com
# Custom EMP work domains for pihole:
RUN echo "server=/emp.internal.com/10.59.0.125,10.100.100.125" >> /etc/dnsmasq.d/01-pihole.conf
RUN echo "server=/emp.local/10.59.0.125,10.100.100.125" >> /etc/dnsmasq.d/01-pihole.conf

#https://github.com/apavamontri/pi-hole-cloudflared-docker/blob/main/docker-compose.yml

# Cloudflared install and setup https://docs.pi-hole.net/guides/dns/cloudflared/
#RUN apt update && apt install -y wget
#RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
#  apt-get install ./cloudflared-linux-amd64.deb && \
#  useradd -s /usr/sbin/nologin -r -M cloudflared
#RUN echo "CLOUDFLARED_OPTS=--port 5053 --upstream https://8.8.8.8/dns-query" > /etc/default/cloudflared
#RUN chown cloudflared:cloudflared /etc/default/cloudflared && \
#  chown cloudflared:cloudflared /usr/local/bin/cloudflared
#COPY ./etc-pihole/cloudflared.service /etc/systemd/system/cloudflared.service
#RUN systemctl enable cloudflared && systemctl start cloudflared
