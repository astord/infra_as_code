# check the images
docker images nginx
# Updates
docker tag nginx:latest nginx:vX.0
docker pull nginx:latest
docker compose down && docker compose up -d && sleep 2 && docker compose ps
