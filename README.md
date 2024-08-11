# Docker networking

- A repo to test our the functionality of networking in Docker

## DNS stuff

- DNS reslution:

```bash

docker network create mo_net

docker run -d --name webserver --network mo_net nginx
docker run -d --name test_client --network mo_net alpine sleep 1000


docker exec test_client ping -c 4 webserver

PING webserver (172.22.0.2): 56 data bytes
64 bytes from 172.22.0.2: seq=0 ttl=64 time=0.070 ms
64 bytes from 172.22.0.2: seq=1 ttl=64 time=0.119 ms
64 bytes from 172.22.0.2: seq=2 ttl=64 time=0.110 ms
^C
```

### HTTP/Curl request (client to web)

- You can also use curl to make an HTTP request to the webserver container from test_client.

```bash

docker exec test_client apk add --no-cache curl
docker exec test_client curl http://webserver
```

Reponse:

```bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   615  100   615    0     0   865k      0 --:--:-- --:--:-- --:--:--  600k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
