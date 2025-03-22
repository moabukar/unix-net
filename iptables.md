# iptables & firewalls in unix

Some labs going through iptables and firewalls in unix.

Make sure your container is running with the base image from the [README](./README.md)

## Lab 1: Basic iptables rules

```bash
## Create a new network namespace
ip netns add demo_ns

## Inside demo_ns, block ICMP (ping) traffic
ip netns exec demo_ns iptables -A INPUT -p icmp -j DROP

## On the host, accept traffic from the 192.168.1.0/24 subnet
iptables -t filter -A INPUT -s 192.168.1.0/24 -j ACCEPT

ip netns exec demo_ns iptables -L -v --line-numbers ## 
ip netns exec demo_ns ping google.com


## On the host, drop all other traffic
iptables -t filter -A INPUT -j DROP
```

#### Summary

- Order Matters: iptables processes rules in order. The first matching rule wins.
- Namespace Separation: The iptables rules you add in the default namespace don’t affect those in demo_ns – each namespace has its own set of firewall rules.
- Fixing the Issue: You need to either remove the drop rule or ensure your accept rule is evaluated first by inserting it at the top.
