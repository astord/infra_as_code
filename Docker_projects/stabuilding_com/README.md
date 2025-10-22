# check the images
docker images nginx
# Updates
docker pull nginx:latest
docker compose restart && sleep 2 && docker compose ps
