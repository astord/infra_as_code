# references
https://github.com/docker/awesome-compose/blob/master/official-documentation-samples/wordpress/README.md

# Clean all

```
docker compose down --volumes --rmi all
```

# Bakcup and Restore

## 1. Wordpress backup

```
###Create the backup tar
docker exec $(docker ps -q --filter "name=wp_example-wordpress-1") tar czf /tmp/wp_backup.tar.gz -C /var/www/html .

###Copy the backup tar from the container to the host /tmp/wp_test_backup
docker cp $(docker ps -q --filter "name=wp_example-wordpress-1"):/tmp/wp_backup.tar.gz /tmp/wp_test_backup/

###Remove the backup tar from the container
docker exec $(docker ps -q --filter "name=wp_example-wordpress-1") rm -rf /tmp/wp_backup.tar.gz
```

## 2. Database backup stored to the host

```
source .env
docker exec $(docker ps -q --filter "name=wp_example-db-1") mysqldump -u wordpress -p$SB_PASS wordpress > /tmp/wp-db-backup-2025-02-22.sql
```

## 3. Wordpress restore

```
#Copy the backup from the host /tmp/wp_test_backup/wp_backup.tar.gz to the container:
docker cp /tmp/wp_test_backup/wp_backup.tar.gz $(docker ps -q --filter "name=wp_example-wordpress-1"):/tmp/

#Extract the tar inside the container:
docker exec $(docker ps -q --filter "name=wp_example-wordpress-1") tar xzf /tmp/wp_backup.tar.gz -C /var/www/html
```

## 4. Database restore from the host stored backup

```
docker exec -i $(docker ps -q --filter "name=wp_example-db-1") mysql -u wordpress -p'wordpress' wordpress < /tmp/wp-db-backup-2025-02-22.sql
```
