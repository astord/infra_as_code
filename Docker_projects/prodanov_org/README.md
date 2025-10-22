# Updates
# check the images
docker images --filter=reference=ubuntu --filter=reference=ubuntu_ssh_scp --filter=reference=nginx

# Tag the current images
docker tag nginx:latest nginx:vX
docker tag ubuntu_ssh_scp:latest ubuntu_ssh_scp:vX
docker tag ubuntu:latest ubuntu:vX

# Pull the latest
docker pull ubuntu:latest
docker pull nginx:latest

# Build
docker compose down scp
docker compose build scp

# Start
docker compose up -d && sleep 2 && docker compose ps
