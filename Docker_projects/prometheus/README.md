
### Before first start
For using prometheus storage on a docker volume create the volume if doesn't exeist:

```
docker volume create time_db
```

### Updates/Upgrades

```
cd <project_dir>
docker tag prom/prometheus:latest prom/prometheus:vX.0 # tag the old image in case of revert is needed
docker compose pull                                    # pulls the latest images
docker compose up -d --no-deps                         # restarts containers with newer images
```
