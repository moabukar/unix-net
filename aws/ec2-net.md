# EC2 Networking

- When dealing with EC2 networking, the most important part is the ENI (Elastic Network Interface) - they control how networking is managed for EC2 instances. Security groups and NACLs are attached to ENIs, and ENIs are attached to EC2 instances. 
- ENIs can be moved between EC2 instances. An EC2 instance can have multiple ENIs attached to it at the same time.
- The ability to attach multiple ENIs to a single instance is useful for various scenarios, such as:
  - Creating dual-homed instances: Instances with workloads or roles on different subnets or networks.
  - Managing traffic: Separating different types of traffic for security or performance reasons.
  - High Availability setups: Using secondary interfaces for failover or redundancy.

- Every ENI is allocated a single primary private IPv4 address which is obtained using DHCP. This IP address remains the same for the lifetime of the ENI, even if it is detached from the EC2 instance. 
- And so EC2 is always launched with a primary network interface, we know that every instance at the very least has one primary private IPv4 address which is static for the lifetime of the interface and thus it's static for the lifetime of the instance.
- So as a foundational facts, by default every EC2 instance has a single primary private IPv4 address that never changes. 
- Primary private IPv4 addresses, ENIs can also be allocated with one or more secondary private IPv4 addresses. 
- Note: IP addresses are linked to the ENI, not the instance.


## Public IPv4 addressing

- If you launch an instance into a subnet which is set to allocated public IPv4 addresses, or if you explicity decide to launch an instance with a public IPv4 address, then it's allocated a public IPv4 address.
- Instead you it's better to have elastic IPs. and you can allocated 1 elastic IP per private IPv4 address. These can be moved between network interfaces and instances.
  - You get charged for elastic IPs when they are not attached to an instance or not being used.
- 

## Advanced EC2 Networking Architectures

- Management or isolated networks by using multiple ENIs.
- Network interfaces can also be used for Software Licensing (MAC)
  - Some legacy software is linked to the MAC address of a specific interface on a specific instance. So you can create a secondary network interface, attach to an instance, use the MAC address for the licensing. And if you need to migrate the software, you can detach the network interface from the instance, move it to another one, attach it and the software will still work because it's licensed based on MAC address which is linked to a specific network interface.
- Security or Network appliances
  - You can use network interfaces to create a security appliance or a network appliance. For example, you can create a network interface, attach it to an instance, install a firewall on that instance, and then attach that network interface to another instance. And now you have a firewall that's protecting the second instance.
- Dual/Multi-homed instances with workloads/roles on specific subnets. 
  - So if you had a mutli-tier app with a web server, an app server and a database server, you could have the webserver communicating with the app on one interface and the database server communicating with the same app server on another interface.
  - And on each interface you can have a different security group or NACLs to control the traffic.
- Low budget & simple HA solutions
  - Imagine you have 2 EC2 instances, which provider access to an app, you could have a secondary network interface, which is associated with one of those instances at any one time. That interface has an IP address, through this IP the server is provided, and if the instance fails, you could migrate that network interface to a different instance and fail over as part of a low budget HA solution.
  - So you have loads of flexibility by creating architectures using multiple network interfaces.


## Bootstrapping vs AMI baking

- Ready for Service Lag (total time between when the ASG requests additional compute instances from EC2 and at the point at which they're ready to serve traffic). As an SA, You should aim to minimise or avoid this period as much as possible as it's what causes a disruption to the service or a bad user experience.
-  App installation architecture
   -   Base installs (very slow and generic)
       -  It doesn't change often between environments, we need to optimise for speed. So minimise the amount of time it takes for the base installation of the app in some way.
   -   App updates (not fast and mostly generic)
       -   
   -   App config (fast but unique across diff envmts)
       - Aim to maintain flexibility since it's already fast. Flexibility is what will allow us to deploy to different clients, environments and regions. So customisation is the focus. 

### How can we reduce ready for service lag?

#### Bootstrapping

- Not that fast but super flexible
- Provision an EC2 instance and add a user data script to it. This script will run when the instance is launched. Using a system called cloud init, the script can be used to install and configure the app.
- Flexible process but takes time. 
- 

#### AMI Baking

- Launch a master EC2 instance. Perform the time consuming tasks such as installing the app and configuring it. You can do bootstrapping here too to get to this ready state. Then once the EC2 is ready, create an AMI from that instance.
- Now, you can use an AMI to create any number of instances quickly & ready to go.
- Because we front-loaded all the time consuming work, time taken to provision EC2 instances is greatly reduced compared to bootstrapping.
- Essentially, using this custom AMI, the provisiong time is the same as if you were using a normal AMI.
- So AMI baking is used when you want to bake into an AMI all the time consuming parts of an installation or configuration.
- The trade off is that it's harder to adjust things once they're AMI baked
  - You can solve this by running a pipeline which creates new AMIs weekly or daily. 
- You can acheive good results by combining both processes.

### Combination Architecture (combining both bootstrapping and AMI baking):

- Provision a base EC2
- Perform the time consuming part of the app install.
  - Create an AMI from that saving that time
- Customise baked AMI at launch time using user data.
  - Any custom config or any sensitive data that you don't want to leave on an AMI, you can use user data and bootstrapping add this at launch time as you launch multiple instances from the AMI.
- And with this, you can get fast provisioning time by using AMI baking. So you bake any time consuming parts into the AMI 
- So essentially AMI Baking for the bigger instance stuff and bootstrap custom config by using bootstrapping at launch time using user data.
- This architecture is often used in production
