### Network Address Translation (NAT)

- NAT is designed to overcome IPv4 shortages. IPv4 are either publically routable or they fail within the private address space. Publically routable addresses are assigned by a central agency and regional agencies which assign them to ISPs. And ISPs allocate them to businses or consumer needs
- An IPv4 publicly routable addresses have to be unique in order to function correctly.
- Private IPv4 addresses such as those in 10.0.0.0 range can be used in multiple places but can’t be routed over the internet.
- And so to give internet access to private devices, we need to use Network Address Translation. on top of this, NAT provides extra security benefits.
- There are multiple types of NAT and all of them translate private IPv4 addresses to public ones so that packets can flow over the public internet and then translate back in reverse. so that internet based hosts can communicate back with these private services. That’s a high level overview of a NAT but each type of NAT handles the process differently.

### Static NAT

- Static NAT: 1 private to 1 fixed public address (internet gateway). In affect, giving that private IP address access to the public internet in both directions. This is how an internet gateway within AWS works.
    - Static NAT is what you would use when certain specific private IP addresses need access to the internet using a public IP and where these IPs need to be consistent.

### Dynamic NAT

- Similar to static NAT but there is no static allocation. Instead you have a pool of public IP addresses to use, and these are allocated as needed. So when private Ip addresses attempt to use the internet for something,
    - This method of NAT is generally used when you have a large number of private IP addresses and want them all to have internet access via public IPs, but when you have less public IPs than private IPs and you want to be efficient in how they’re used.

### Port Address Translation (PAT)

- Many private IPs translated to 1 public IP (NAT GW)
- This is likely what your home internet router does. You might have many devices like phones, laptops etc - and all of these will use PAT, aka overloading to use a single public IP. This method as the name suggest uses ports to identify devices.
- This is the actually the method that the NAT GW or NAT instances use within AWS.
- NAT as a process only makes sense for IPv4.. not IPv6. Since IPv6 has so many addresses, we don’t need a form of private addressing. and as such as we don’t need translation.
- With IPv6 generally, you don’t need any form of NAT.

### Summary of NAT

- A **static NAT** is similar to how the Internet Gateway in AWS works. 1 to 1 static network address translation
- With **dynamic NAT**, multiple private IPs can share a single public IP as long as there is no overlap. As long as the devices, use the allocations at different times.
    - With dynamic NAT, because the shared public pool of IPs are used, it’s possible to run out of public IPs to allocate.
    - This type of NAT is used when you have less public IPs than private ones, but when all of the private IPs at some time need public access, which is bidirectional.
- **PAT (Port Address Translation)**: is what allows a large number of private IPs to share one public IP
    - It’s how the AWS NAT GW functions.
    - It has a many to 1 mapping architecture. Many private IPv4 addresses are mapped onto one public IPv4 address.
    - Multiple devices are given unique public ports within the public address provided by the nat gateway. So laptop A (which has a private address) can have a public address of 52.95.36.67 with source port 1337 and laptop B can have the same public address here but with source port 1338 to communicate with the internet.
    - So the NAT devices is creating a NAT table to store these ports. which has:
        - Private IP, Private Port & Public IP (of the NAT GW) & Public port (which is unique)
    - It’s how your home router works and how NAT GW within AWS works
    - Why PAT you can’t initiate traffic to these private devices:
        - because without an entry in the NAT table, the NAT device won’t know to which device traffic should be translated and forwarded to.
