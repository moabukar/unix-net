# Docker networking

- A repo to test our the functionality of networking in Docker

## DNS stuff

```bash

docker network create mo_net

docker run -d --name webserver --network mo_net nginx
docker run -d --name test_client --network mo_net alpine sleep 1000


docker exec test_client ping -c 4 webserver


docker exec test_client apk add --no-cache curl
docker exec test_client curl http://webserver


```
