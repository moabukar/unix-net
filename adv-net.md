# Network troubleshooting

- Below are useful networking tools that I use daily for troubleshooting any networking issues. Maybe there are more.

### Ping 

- Tests connectivity to a specific IP address or hostname.
    - ping sends ICMP echo requests to a specified address to check connectivity.

```bash
ping google.com
ping -c 4 192.168.1.1
```

### Traceroute

- Displays the route packets take to a network host. so basically check the network hops your packets take to a certain destination

```bash
traceroute google.com
traceroute -I 192.168.1.1
```

## netcat (nc) 

- Reads and writes data across network connections using TCP or UDP.

```bash
nc -zv google.com 80
nc -l 1234  # Listen on port 1234
```

### Telnet

- Connects to another host using the Telnet protocol.

```bash
telnet google.com 80
```

### nslookup 

- Queries DNS to obtain domain name or IP address mapping.

```bash
nslookup google.com
nslookup 8.8.8.8
```

### Dig

- Queries DNS servers for information about domains. (Advanced version of nslookup)

```bash
dig google.com
dig google.com ANY
```

### IP

- Shows/manages network interfaces, routing, and addresses.

```bash
ip addr show
ip route show
ip link set eth0 up
```

### ifconfig

- Configures network interfaces.

```bash
ifconfig
ifconfig eth0 up
```

### netstat 

- Displays network connections, routing tables, interface statistics.

```bash
netstat -an
netstat -r
```

### ss

- Dumps socket statistics, similar to netstat.

```bash
ss -tuln
ss -s
```

### tcpdump

- Captures and analyzes network traffic.

```bash
tcpdump -i eth0
tcpdump -i eth0 -w capture.pcap
```

### iperf

- Measures network bandwidth.

```bash
iperf -s  # Start server
iperf -c server_ip  # Connect to server
```

### mtr

- Combines ping and traceroute functionality.

```bash
mtr google.com
mtr -r google.com
```

### route

Displays or modifies the IP routing table.

```bash
route -n
route add default gw 192.168.1.1
```

### nmap

- Network exploration tool and security/port scanner. (check which ports are open for a certain domain or IP)

```bash
nmap google.com
nmap -sP 192.168.1.0/24
```

### whois

- Queries the WHOIS database for information about domains. - who owns the domain and belongs to etc

```bash
whois google.com
```

### arp

- Displays and modifies the ARP table. (ARP is the mapping of MAC addresses to IP addresses)

```bash
arp -a
arp -d 192.168.1.1
```

### hostname

- Shows or sets the system's hostname.

```bash
hostname
hostname new-hostname
```

### lsof

- Lists open files and network connections.

```bash
lsof -i :80
lsof -i tcp
```
