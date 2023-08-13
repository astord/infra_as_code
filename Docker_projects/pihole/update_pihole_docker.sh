#!/bin/bash
PROJECT_PATH='/infra/git/infra_as_code/Docker_projects/pihole/'

if [ $# -eq 0 ]; then
    >&2 
    echo "Updates the pihole images with the latest image from hub.docker.com"
    echo -e "Usage:\nbash $0 <current_version>/<tag>\n"
    echo "Current images:"
    docker images smb
    exit 1
fi

cd $PROJECT_PATH
echo -e "\nTag the old image"
docker tag pihole:latest pihole:$1
echo -e "\nBuild new 'latest' image"
docker compose build --no-cache
echo -e "\nReplace the running container"
docker compose down
docker compose up -d
echo -e "\nAll pihole images now:"
docker images pihole
echo -e "\n(Optional) Remove the left public pihole image"
echo "docker rmi pihole:<tag>"
