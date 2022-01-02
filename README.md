# infra_as_code
Docker Vagrant Terraform

# Docker

### Network examples

- ipvlan network:

```
docker network create -d ipvlan --subnet 10.0.0.0/24 --gateway 10.0.0.1 -o parent=enp1s0 test_ipvlan
```
