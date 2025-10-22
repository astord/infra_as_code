#!/bin/bash
PROJECT_PATH='/infra/git/infra_as_code/Docker_projects/mon_prometheus_grafana/'

if [ $# -lt 2 ]; then
    >&2
    echo "Updates the prometheus and grafana images with the latest image from hub.docker.com"
    echo -e "Usage:\nbash $0 <current_prometheus_image_tag> <current_grafana_image_tag>\n"
    echo -e "Current images:\n"
    docker images prom/prometheus && docker images grafana/grafana
    exit 1
fi

cd $PROJECT_PATH
echo -e "\nTag the old images"
docker tag prom/prometheus:latest prom/prometheus:$1
docker tag grafana/grafana:latest grafana/grafana:$2
echo -e "\nPull the 'latest' images"
docker compose pull
echo -e "\nReplace the running containers"
docker compose down
docker compose up -d
echo -e "\nAll images now:"
docker images prom/prometheus && docker images grafana/grafana
echo -e "\n(Optional) Remove the left public pihole image"
echo "docker rmi prom/prometheus:<tag>\ndocker rmi grafana/grafana:<tag>"
echo "IMPORTANT: After grafana docker is up, it's possible to take 5 mins. prior become accessible!"
