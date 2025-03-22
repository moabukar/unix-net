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

## Pod Architecture

- Running a container under Docker places that container in its own private network namespace by default.
- Kubernetes collects sets of containers in Pods.
- All the containers in a pod share the same network namespace.

### Pod Networking

- All pods are assigned their own unique IP address.
- Nodes run a root network namespaces that bridges between the pod interfaces. This allows all pods to communicate with each other using their IP addresses, regardless of the node they are running on.
- Communication does not depend on NAT so less complexity and portability.
- Pods are assigned their own network namespaces and interfaces. All communication with pods go through their assigned interfaces.
- The cluster-level network layer maps the Node-level namespaces, allowing traffic to be correctly routed across Nodes.
- Most K8s networking plugins support IPAM.

## DNS in K8s

- K8s clusters built-in DNS support. CoreDNS is the most popular DNS server for K8s and comes enabled by default in many k8s distributions.

K8s automatically assigns DNS names to pods and services like this:

- Pod – `pod-ip-address.pod-namespace-name.pod.cluster-domain.example` (e.g. `10.244.0.1.my-app.svc.cluster.local`)
- Service – `service-name.service-namespace-name.svc.cluster-domain.example` (e.g. `database.my-app.svc.cluster.local`)

The applications running in your Pods should usually be configured to communicate with Services using their DNS names. Names are predictable, whereas a Service’s IP address will change if the Service is deleted and then replaced.