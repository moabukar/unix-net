# Network troubleshooting

- Below are useful networking tools that I use daily for troubleshooting any networking issues. Maybe there are more.

## Usage

```bash

# Tests connectivity to a specific IP address or hostname.
ping google.com
ping -c 4 192.168.1.1

# Displays the route packets take to a network host. so basically check the network hops your packets take to a certain destination
traceroute google.com
traceroute -I 192.168.1.1

# netcat (nc) Reads and writes data across network connections using TCP or UDP.
nc -zv google.com 80
nc -l 1234  # Listen on port 1234

# Connects to another host using the Telnet protocol.
telnet google.com 80

# Queries DNS to obtain domain name or IP address mapping.
nslookup google.com
nslookup 8.8.8.8

# Queries DNS servers for information about domains. (Advanced version of nslookup)
dig google.com
dig google.com ANY

# Shows/manages network interfaces, routing, and addresses.
ip addr show
ip route show
ip link set eth0 up

# Configures network interfaces.
ifconfig
ifconfig eth0 up

# Displays network connections, routing tables, interface statistics.
netstat -an
netstat -r

# Dumps socket statistics, similar to netstat.
ss -tuln
ss -s

# Captures and analyzes network traffic.
tcpdump -i eth0
tcpdump -i eth0 -w capture.pcap

# Measures network bandwidth.
iperf -s  # Start server
iperf -c server_ip  # Connect to server

# Combines ping and traceroute functionality.
mtr google.com
mtr -r google.com

# Displays or modifies the IP routing table.
route -n
route add default gw 192.168.1.1

# Network exploration tool and security/port scanner. (check which ports are open for a certain domain or IP)
nmap google.com
nmap -sP 192.168.1.0/24

# Queries the WHOIS database for information about domains. - who owns the domain and belongs to etc
whois google.com

# Displays and modifies the ARP table. (ARP is the mapping of MAC addresses to IP addresses)
arp -a
arp -d 192.168.1.1

# Shows or sets the system's hostname.
hostname
hostname new-hostname

```
