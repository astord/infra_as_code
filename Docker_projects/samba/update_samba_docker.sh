#!/bin/bash
PROJECT_PATH='/infra/git/infra_as_code/Docker_projects/samba/'

if [ $# -eq 0 ]; then
    >&2 
    echo "Updates the samba image with the latest image from hub.docker.com"
    echo -e "Usage:\nbash $0 <current_image_version>/<tag>\n"
    echo "Current images:"
    docker images smb
    exit 1
fi

cd $PROJECT_PATH
echo -e "\nTag the old image"
docker tag smb:latest smb:$1
echo -e "\nBuild new 'latest' image"
docker compose build --no-cache
echo -e "\nReplace the running container"
docker compose down
docker compose up -d
echo -e "\nAll samba images now:"
docker images smb
echo -e "\n(Optional) Remove the left images"
echo "docker rmi samba:<tag>"
