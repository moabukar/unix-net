## DNS

- DNS is a distributed huge database which converts DNS names to IP addresses and vice versa.
- Why do we need loads of DNS servers?
  - Risk problem of attackers attacking one server and prevent requests
  - Scaling problem: Almost everone using DNS globally. This represents a massive and growing load on the system. A single server or a small group of servers can only get so big and it cannot scale properly.
- DNS is a huge database and current estimates of domain names are around 341 million. This is a huge database and it is distributed across the world.
- 340+ million domains like google.com, amazon.com etc and each one of those domains have many records >> and this is a huge data volume problem

- **DNS Zone**
    - a database e.g. [netflix.com](http://netflix.com) containing records
    - that zone is stored on a disk somewhere and it’s called a Zonefile
    - Nameservers (NS) - a DNS server which hosts 1 or more zones and stores 1 or more Zonefiles
    - Authoritative - contains real/genuine records (boss of the domain) - single source of truth for the particular zone
    - Non-authoritative/cached - copies of records/zones stored elsewhere to speed things up. For e.g. your local router or ISP might for instance be able to provide non-authoritative or cached answer for [google.com](http://google.com) or [youtube.com](http://youtube.com) because you visited the sites before. Only the nameservers of YT can give an authoritative answer

- **DNS Architecture**
    - **DNS Root**: the boss. This zone is hoted on DNS nameservers. So the DNS root zone runs on the DNS root servers. It’s the point that every DNS client knows about and trusts. It’s where queries start and at the root of DNS. There are 13 root server IPs which host the root zone. These IPs are distributed geographically and the hardware is managed by independent orgs.
        - The root zone is just a database and it’s managed by the internet assigned numbers authority aka IANA
        - Root zone only stores high level info on top level domains aka TLDs and no other details.
            - 2 types of TLDs: generic TLD such as .com and country code specific such as .uk or .au. IANA delegate the management of these TLDs to other orgs known as registries. The job of the root zone is to just point at these TLD registries. So IANA delegate mgmt of .com TLD to Verisign. meaning Verisign is the .com registry.
        - A summary is that: The Root zone is pointing at the nameservers hosting the TLD zones run by the registries which are the orgs who managed these TLDs. So Verisign will operate some nameservers hosting the .com TLD zone and the root zone will have records for the .com TLD which point at these .com NS.
        - TLDs point at the nameservers which host the [netflix.com](http://netflix.com) and [twitter.com](http://twitter.com) zones. This 2nd level being pointed are known as authoritative nameservers
        - These nameservers host the zone for a given domain for e.g. [netflix.com](http://netflix.com). This means the server host the Zonefile which stores the data for that zone. At this 3rd level, the zone contains records within netflix.com. so [www.netflix.com](http://www.netflix.com) points at a set of IP addresses.
    - Summary: The root zone knows which nameservers the .com zone is on, the .com zone knows which nameservers [netflix.com](http://netflix.com) is on. and the netflix.com zone contains records for the netflix.com domain and can answer queries.

### How DNS works

What do we want from DNS?

- So in simple, we have a client and it wants to access [netflix.com](http://netflix.com). and we need the IP address or addresses which we can connect to in order to access Netflix. Somewhere in the world there is a DNS zone for netflix.com which has these and contains the records, which links [www.netflix.com](http://www.netflix.com) to 1 or more IPs .How do we find this zone
    - That’s what DNS does. It’s the job of DNS which allows you to locate the specific DNS zone and get a query response from the authoritative zone which hosts the DNS records you need
- DNS is huge global distributed database containing lots of DNS records and the function of DNS is to allow you to locate the specific zone which can give you an authoritative answer.
- **Example of a query within DNS:** >> like the Google.com question
    - Imagine we are querying www.netflix.com. First thing to check is the local DNS cache and hostsfile on the local machine. The hosts file is a static mapping of names to IPs and overrides DNS. Assuming the local client isn’t aware of the DNS name, then next step:
    - A resolver comes in here. A resolver is a type of DNS server often running  on a home router or within an ISP and it will do the query on our behalf. So we send the query to the DNS resolve and it will query for you. The resolver also has a local cache which is used to speed up DNS queries. So if someone has queried [netflix.com](http://netflix.com) before, it might be able to return a non-authoritative answer aka local cached response. Assume now there is no cached entry for netflix.com, then the resolve queries the root zone via one of the root servers. Every DNS server will have these IPs hardcoded and this list is maintained by the OS vendor. The DNS root won’t be able to answer us coz it isn’t aware of netflix.com but it can help us get closer
    - The root zone contains the records of a .com specifically nameserver records which point at the nameservers for the .com TLD and it returns .com NS
    - So now the DNS resolver can now query one of the .com TLD NS for [www.netflix.com](http://www.netflix.com). Assuming that the netflix.com domain has been registered, the .com zone will contain entries for netflix.com. Then the details of netflix.com NS are returned to the DNS resolver. The resolver can now move on:
    - The DNS resolve now queries the [netflix.com](http://netflix.com) NS for [www.netflix.com](http://www.netflix.com) and because these NS are authoritative for this domains as they host the zone and zonefile for this domain and they’re pointed at by the .com TLD zone, they can return an authoritative response back to the resolver.
    - Now the DNS resolver caches the result in order to improve performance
    - Now the DNS resolver caches the result in order to improve performance for future queries.
    - And this DNS resolver returns the result to our local machine. This is how every DNS query works.
    - Note: No one single Nameserver has all the answers, not even the root NS. But, every query gives you the next step and takes you closer to your query.
        - The root gives you the .com NS, the .com NS gives you the [netfli](http://netflic.com)x.com NS, and the netflix.com NS can give you an authoritative answer
    - This DNS process is also known as “Walking the (”DNS”) tree”
    - This process is on a high level.
- **A bit deeper**
    - Start with root zone when the DNS resolver is querying the root zone. The root zone doesn’t have the info needed but it does know which NS handles .com NS so it can provide this. These NS are run by Verisign which manages the .com TLD. These NS host the .com zone file.
    - We can now query the .com zone. We can’t get answer directly from here but it does know which NS are authoritative for [netflix.com](http://netflix.com). These are the network addresses of the servers which host the netflix.com zone and this is authoritative. This gives us what we need (they look like `[ns-81.awsdns-10.com](http://ns-81.awsdns-10.com)` , `[ns-659.awsdns-18.net](http://ns-659.awsdns-18.net)` etc
    - The above are not IPs, they are another DNS name. This is a CNAME record. To get the IP address for this, you follow the same process again.
