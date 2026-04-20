# references
https://github.com/docker/awesome-compose/blob/master/official-documentation-samples/wordpress/README.md

# Clean all

```
docker compose down --volumes --rmi all
```
# Updates/Patching

List current images:

```
docker images --filter=reference=wordpress --filter=reference=mariadb
```

```
#Tag the old images (for mariadb we have static tags):
docker tag wordpress:latest wordpress:vX.0
#Pull the latest cloudflared image:
docker compose pull
#Replace the running container
docker compose down && sleep 1 && docker compose up -d && docker compose ps
#Remove the left public pihole image:
docker rmi wordpress:vX.0
docker rmi mariadb:....
```


# Bakcup and Restore

## 1. Wordpress backup

```
###Create the backup tar
docker exec $(docker ps -q --filter "name=monikanova-wp-1") tar czf /tmp/wp_backup-$(date -I).tar.gz -C /var/www/html .

###Copy the backup tar from the container to the host /tmp/wp_test_backups
mkdir -p /tmp/wp-backups/
docker cp $(docker ps -q --filter "name=monikanova-wp-1"):/tmp/wp_backup-$(date -I).tar.gz /tmp/wp-backups/

###Remove the backup tar from the container
docker exec $(docker ps -q --filter "name=monikanova-wp-1") rm -rf /tmp/wp_backup-$(date -I).tar.gz
```

## 2. Database backup stored to the host

```
mkdir -p /tmp/wp-backups
source .env
docker exec $(docker ps -q --filter "name=monikanova-db-1") mysqldump -u wordpress -p$DB_PASS wordpress > /tmp/wp-backups/wp-db-backup-$(date -I).sql
```

## 3. Wordpress restore

```
#Copy the backup from the host $WP_BACKUP_DIR/$WP_BACKUP_TAR (`/tmp/wp-backups/some_name.tar.gz`) to the container:
WP_BACKUP_DIR=/tmp/wp-backups
WP_BACKUP_TAR=some-name.tar.gz
docker cp $WP_BACKUP_DIR/$WP_BACKUP_TAR $(docker ps -q --filter "name=monikanova-wp-1"):/tmp/

#Extract the tar inside the container:
docker exec $(docker ps -q --filter "name=monikanova-wp-1") tar xzf /tmp/$WP_BACKUP_TAR -C /var/www/html

#Delete the backup tar from the container
docker exec $(docker ps -q --filter "name=monikanova-wp-1") rm -rf /tmp/$WP_BACKUP_TAR
```

## 4. Database restore from the host stored backup

```
WP_BACKUP_DIR=/tmp/wp-backups
WP_DB_BACKUP=some_name.sql
source .env
docker exec -i $(docker ps -q --filter "name=monikanova-db-1") mysql -u wordpress -p$DB_PASS wordpress < $WP_BACKUP_DIR/$WP_DB_BACKUP
```
