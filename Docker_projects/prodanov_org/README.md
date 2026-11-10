# Updates
# check the images
docker images --filter=reference=ubuntu --filter=reference=ubuntu_ssh_scp --filter=reference=nginx --format "table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.CreatedAt}}\t{{.Size}}"

# Tag the current images BEFORE pulling/building (rollback copies)
docker tag nginx:latest nginx:vX
docker tag ubuntu_ssh_scp:latest ubuntu_ssh_scp:vX

# Pull the latest nginx (only "web": the scp image is built locally, not on Docker Hub)
docker compose pull web

# Rebuild the scp image from the newest ubuntu base, re-running apt-get
docker compose build --pull --no-cache scp

# Recreate whatever changed
docker compose up -d && sleep 2 && docker compose ps
