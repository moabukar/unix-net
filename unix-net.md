# UNIX networking


- Note: Use dockerfile in root for testing the below

```bash
docker build -t container-unix .
docker run -it --privileged --name container-unix container-unix /bin/sh
```

## Custom network namespace in UNIX

```bash
# Create a new network namespace using ip netns.
ip netns add my_namespace
# Create a pair of virtual Ethernet devices.
ip link add veth0 type veth peer name veth1

# Move one end of the virtual Ethernet pair to the new namespace.
ip link set veth1 netns my_namespace

# Set up the interfaces in both the default namespace and the new namespace.
ip addr add 192.168.1.1/24 dev veth0
ip link set veth0 up
ip netns exec my_namespace ip addr add 192.168.1.2/24 dev veth1
ip netns exec my_namespace ip link set veth1 up
ip netns exec my_namespace ip link set lo up

# Test connectivity between the default namespace and the new namespace.
ip netns exec my_namespace ping 192.168.1.1

```


## VLANs

```bash

# Create & Add a VLAN interface to one of the virtual Ethernet devices.
ip link add link veth0 name veth0.10 type vlan id 10
ip addr add 192.168.10.1/24 dev veth0.10
ip link set veth0.10 up


# Set up the VLAN interface in the network namespace.
ip netns exec my_namespace ip link add link veth1 name veth1.10 type vlan id 10
ip netns exec my_namespace ip addr add 192.168.10.2/24 dev veth1.10
ip netns exec my_namespace ip link set veth1.10 up

# Verify connectivity over the VLAN.
ip netns exec my_namespace ping 192.168.10.1

```

## Network performance testing

```bash

# Run iperf in server mode in one container and client mode in another to test network performance.
iperf -s   # In server container
iperf -c <server_ip>  # In client container


# Capture Packets and analyse traffic

tcpdump -i eth0
```
