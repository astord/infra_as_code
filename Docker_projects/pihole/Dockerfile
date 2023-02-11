FROM pihole/pihole:latest
# Disable rate limit
RUN echo 'RATE_LIMIT=0/0' >> /etc/pihole/pihole-FTL.conf
# Add addresses to whitelist
RUN pihole -w s.youtube.com
