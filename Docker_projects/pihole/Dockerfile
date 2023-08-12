FROM pihole/pihole:latest
# Disable rate limit
RUN echo 'RATE_LIMIT=0/0' >> /etc/pihole/pihole-FTL.conf
# Add addresses to whitelist
RUN pihole -w s.youtube.com
# Custom EMP work domains for pihole:
RUN echo "server=/emp.internal.com/10.59.0.125,10.100.100.125" >> /etc/dnsmasq.d/01-pihole.conf
RUN echo "server=/emp.local/10.59.0.125,10.100.100.125" >> /etc/dnsmasq.d/01-pihole.conf
