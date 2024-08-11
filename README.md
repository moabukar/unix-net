# Docker networking


## Theory

### Default Bridge Network

- Bridge Network: By default, Docker creates a network named bridge when it starts.
- Virtual Switch: This bridge acts as a virtual switch, allowing containers to connect and communicate if they are on the same bridge network.
- Default CIDR: Docker assigns the subnet 172.17.0.0/16 to the default bridge network.
    - Example: Container IPs might look like 172.17.1.6​ (Docker Documentation)​ 

### IP Allocation

- DHCP Allocation: Each container receives an IP address from the bridge network's subnet when it starts, managed by Docker's built-in DHCP.

### Custom Networks

- Custom CIDR: You can create custom networks with specified CIDRs for more control over IP address allocation.

### Embedded DNS Server

- Service Discovery: Docker has an embedded DNS server that provides automatic service discovery for containers.
- Dynamic DNS Updates: The DNS server is automatically updated when a new container starts.

### Hostnames and Container IDs

- Hostname Resolution: Containers can communicate using hostnames, which by default are the container IDs.

Summary: 

- Docker's default bridge network uses 172.17.0.0/16 CIDR.
- Containers receive IPs via DHCP.
- Custom networks with specific CIDRs can be created.
- Docker’s embedded DNS server provides automatic service discovery and hostname resolution.
- Containers can communicate using hostnames, typically the container IDs, within the same network.

## Lab

- A repo to test our the functionality of networking in Docker

### Basic test

- Create 2 containers in same net and ping them for a response. 

```bash

docker run -d --name container1 --network my_network nginx
docker run -d --name container2 --network my_network alpine sleep 1000

docker exec container2 ping container1

## Opposite Test:

- Attempt to ping a container not in the same network, and it should fail to get a response.

```


### DNS stuff

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