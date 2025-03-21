# K8s Networking Theory

- Kubernetes is just networking. 

## Container Networking

There's no such thing as a container. 

### cgroups
The linux kernel has cgroups. They are control groups and they control how much cpu, memory, etc a process can use. Linux kernel has namespaces. They are isolation boundaries and isolate what a process can see. Can your process see itself and its children or can it see the pids of other processes? 

### network namespaces
What we care about is the network namespace. A network namespace makes it so that a process can have its own virtual copy of the ip/network stack. 

- There are just processes running on the host/linux. 
- But, we can isolate a process using Linux namespaces. 
- A network namespace gives a process and its children a virtual ip stack. 

Network namespces include copies of:
- Interfaces
  - loopback
  - eth0
- Routes
- IP tables etc

Inside what we think of as a container, you have your own route table, your own interfaces, your own ip tables, loopback, etc. Now, we can reliably deploy things that listen on port 80 many many times on the same host because they all have their own interfaces. 

Then you have all of this magic happening etc. And with containers, you have reliable deployment. But you need something to kind of orchestrate all of this. To make the deployment work etc.

And that's where Kubernetes comes in. 

## Pod Networking

- Running a container 