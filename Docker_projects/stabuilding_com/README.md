# check the images
docker images nginx
# Updates
docker tag nginx:latest nginx:vX.0
docker pull nginx:latest
docker compose restart && sleep 2 && docker compose ps
