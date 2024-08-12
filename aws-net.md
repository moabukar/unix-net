# AWS Networking

- AWS networking basics

## AWS VPC Basics

### CIDR: 

Block of IP address 
- Example: 192.168.0.0/26: 192.168.0.0 –192.168.0.63 (64 IP) 
- Used for security groups, route tables,  VPC, subnets, etc… 

Private IP 
- 10.0.0.0 –10.255.255.255  (10.0.0.0/8)    <= in big networks 
- 172.16.0.0 –172.31.255.255 (172.31.0.0/12) 
- 192.168.0.0 –192.168.255.255 (192.168.0.0/16)  <= example: home networks 

Public IP 

- All the rest

### VPC 

- A VPC must have a defined list of CIDR blocks, that cannot be changed 
- Each CIDR within VPC: min size is /28, max size is /16 (65536 IP addresses) 
- VPC is private, so only Private IP CIDR ranges are allowed

#### VPC Structure (Example)

- Split VPC into 4 in 1 region (3 AZs + 1 spare)
- And in all these, you have web tier, app tier, db tier and spare
- This creates 4 * 4 = 16 subnets in total
  - If the total VPC CIDR range is /16, then each subnet here would be /20

### Subnets 

- Within a VPC, defined as a CIDR that is a subset of the VPC CIDR - - All instances within subnets get a private IP
-  First 4 IP and last one in every subnet is reserved by AWS 
  
### Route Tables 
- Used to control where the network traffic is directed to 
- Can be associated with specific subnets 
- The “most specific” routing rule is always followed (192.168.0.1/24 beats 0.0.0.0/0)

## Internet Gateway (IGW) 

- Helps our VPC connect to the internet, HA, scales horizontally 
- Acts as a NAT for instances that have a public IPv4 or public IPv6 •

Public Subnets 

- Has a route table that sends 0.0.0.0/0 to an IGW 
- Instances must have a public IPv4 to talk to the internet 

Private Subnets 

- Access internet with a NAT Instance or NAT Gateway setup in a public subnet 
- Must edit routes so that 0.0.0.0/0 routes traffic to the NAT

## NAT Instance

- EC2 instance you deploy in a public subnet 
- Edit the route in your private subnet to route 0.0.0.0/0 to your NAT instance 
- Not resilient to failure, limited bandwidth based on instance type, cheap 
- Must manage failover yourself
- Must disable Source/Destination Check (EC2 setting)

### NAT GW

- Managed NAT solution, bandwidth scales automatically 
- Resilient to failure within a single AZ 
- Must deploy multiple NAT Gateways in multiple AZ for HA 
- Has an Elastic IP, external services see the IP of the NAT Gateway as the source

### Network ACL (NACL) 

- Stateless firewall defined at the subnet level, applies to all instances within •Support for allow and deny rules 
- Stateless = return traffic must be explicitly allowed by rules  
- Helpful to quickly and cheaply block specific IP addresses •
  
### Security Groups 

- Applied at the instance level, only support for allow rules, no deny rules 
- Stateful = return traffic is automatically allowed, regardless of rules 
- Can reference other security groups in the same region (peered VPC, cross-account)


### VPC Flows Logs 

- Log internet traffic going through your VPC 
- Can be defined at the VPC level, Subnet level, or ENI-level 
- Helpful to capture “denied internet traffic” 
- Can be sent to CloudWatch Logs and Amazon S3 

### Bastion Hosts 

- SSH into private EC2 instances through a public EC2 instance (bastion host) 
- You must manage these instances yourself (failover, recovery) 
- SSM Session Manager is a more secure way to remote control without SSH

### VPC Peering

- Connect two VPC, privately using AWS’ network 
- Make them behave as if they were in the same network 
- Must not have overlapping CIDR 
- VPC Peering connection is not transitive (must be established for each VPC that need to communicate with one another) 
- You can do VPC peering with another AWS account 
- You must update route tables ineach VPC’s subnets to ensure instances can communicate

#### Invalid Configs in VPC Peering

- Overlapping CIDR for IPv4
- No Transitive VPC Peering
- No Edge to Edge Routing (VPC Peering does not support edge to edge routing for NAT devices)

### Transit Gateway

- For having transitive peering between thousands of VPC and on-premises, hub-and-spoke (star) connection 
- Regional resource, can work cross-region 
- Share cross-account using Resource Access Manager (RAM) 
- You can peer Transit Gateways across regions 
- Route Tables: limit which VPC can talk with other VPC 
- Works with Direct Connect Gateway, VPN connections 
- Supports IP Multicast(not supported by any other AWS service) 
- Instances in a VPC can access a NAT Gateway, NLB, PrivateLink, and EFS in others VPCs attached to the AWS Transit Gateway.

#### Transit Gateway - Central NAT GW

- There are different VPCs with different CIDRs. App 1 VPC and App 2 VPC. 
- The NAT Gateway is shared in the EgressVPC 
- The private App VPC can access internet through the TGW 
- In this example: the App VPCs cannot communicate with each other based on the TGW route table

#### Transit Gateway - Sharing through RAM (other methods)

- You can use AWS RAM to share a Transit Gateway for VPC attachments across accounts or across AWS Organization

- Transit Gateway Use Different Route Tables to Prevent VPC from Communicating

- Transit Gateway to Direct Connect Gateway

- Transit Gateway –Inter & Intra Region Peering 
  - You can use a Hub TGW for inter-region peering and then peer those Hub TGW with other TGW in other regions.

### VPC endpoints 

- Endpoints allow you to connect to AWS Services using a private network instead of the public www network 
- They scale horizontally and are redundant 
- No more IGW, NAT, etc… to access AWS Services 
- VPC Endpoint Gateway (S3 & DynamoDB) 
- VPC Endpoint Interface (all except DynamoDB) 
- In case of issues: 
  - Check DNS Setting Resolution in your VPC 
  - Check Route Tables 

### VPC Endpoint Gateway

- Only works for S3 and DynamoDB, must create one gateway per VPC
- Must update route tables entries 
- Gateway is defined at the VPC level
- DNS resolution must be enabled in the VPC 
- The same public hostname for S3 can be used 
- Gateway endpoint cannot be extended out of a VPC (VPN, DX, TGW, peering)

### VPC Endpoints Interface

- Provision an ENI that will have a private endpoint interface hostname 
- Leverage Security Groups for security 
- Private DNS (setting when you create the endpoint) 
  - The public hostname of a service will resolve to the private Endpoint Interface hostname 
  - VPC Setting: “Enable DNS hostnames” and “Enable DNS Support” must be 'true’ 
  - Example for Athena: 
    - vpce-0b7d2995e9dfe5418-mwrths3x.athena.us-east-1.vpce.amazonaws.com 
    - vpce-0b7d2995e9dfe5418-mwrths3x-us-east-1a.athena.us-east-1.vpce.amazonaws.com 
    - vpce-0b7d2995e9dfe5418-mwrths3x-us-east-1b.athena.us-east-1.vpce.amazonaws.com 
    - athena.us-east-1.amazonaws.com (private DNS name) 

- Interface can be accessed from Direct Connect and Site-to-Site VPN

### VPC Endpoint Policies 

- Endpoint Policies are JSON documents to control access to services - Does not override or replace IAM user policies or service-specific policies (such as S3 bucket policies)

```json

{
  "Statement": [
    {
      "Action": "sqs:SendMessage",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:us-east-1:123456789012:queue1",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:user:user1"
      }
    }
  ]
}

```

- Note: the IAM user can still use other SQS API from outside the VPC Endpoint 
- You could add an SQS queue policy to deny any action not done through the VPC endpoint

### VPC Endpoint Policy & S3 bucket policy

- VPC Endpoint Policy to restrict access to bucket “my_secure_bucket”

```json

{
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::my_secure_bucket",
        "arn:aws:s3:::my_secure_bucket/*"
      ],
      "Principal": "*",
      "Condition": {
        "StringEquals": {
          "aws:sourceVpce": "vpce-1a2b3c4d"
        }
      }
    }
  ]
}

```

### VPC Endpoint Policy & S3 bucket policy

- VPC Endpoint Policy to allow access to Amazon Linux 2 repositories. 

```json

{
  "Statement": [
    {
      "Sid": "AmazonLinux2RepoAccess",
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::amazonlinux",
        "arn:aws:s3:::amazonlinux/*"
      ],
      "Principal": "*",
      "Condition": {
        "StringEquals": {
          "aws:sourceVpce": "vpce-1a2b3c4d"
        }
      }
    }
  ]
}
```


### VPC Endpoint Policies for S3 Troubleshooting

- Check VPC DNS settings 
- DNS resolution must be enabled
- Route table: must have route to S3 Using gateway VPC Endpoint
- VPC Endpoint Gateway: Check VPC Endpoint Policy
- Verify S3 bucket policy
- Check IAM permissions


### AWS PrivateLink

- Most secure & scalable way to expose a service to 1000s of VPC (own or other accounts)
- Does not require VPC peering, internet gateway, NAT, route tables… - Requires a network load balancer (Service VPC) and ENI (Customer VPC)
- If the NLB is in multiple AZ, and the ENI in multiple AZ, the solution is fault tolerant!

### Site to Site VPN (AWS Managed VPN)

- On-premises: 
  - Setup a software or hardware VPN appliance to your on-premises network. 
  - The on-premises VPN should be accessible using a public IP •

- AWS-side: 
  - Setup a Virtual Private Gateway (VGW) and attach to your VPC 
  - Setup a Customer Gateway to point the on-premises VPN appliance

- Two VPN connections (tunnels) are created for redundancy, encrypted using IPSec 
- Can optionally accelerate it using Global Accelerator (for worldwide networks)

### Route Propagation in Site-to-Site VPN

- Static Routing: 
  - Create static route in corporate data center for 10.0.0.1/24 through the CGW 
  - Create static route in AWS for 10.3.0.0/20 through the VGW •

- Dynamic Routing (BGP): 
  - Uses BGP (Border Gateway Protocol) to share routes automatically (eBGP for internet) 
  - We don’t need to update the routing tables, it will be done for us dynamically 
  - Just need to specify the ASN (Autonomous System Number) of the CGW and VGW

### S2S VPN & internet access

- Can't use NAT GW for the internet
- Can use self managed NAT instance (as there is more control)
- Can use on-premise NAT

### Client VPN

- Connect from your computer using OpenVPN to your private network in AWS and on-premises 

- Client VPN is compatible with VPC peering
- Access On-Premises resources through AWS with Client VPN

### Direct Connect (DX)

- Provides a dedicated private connection from a remote network to your VPC 
- Dedicated connection must be setup between your DC and AWS Direct Connect locations •More expensive than running a VPN solution 
- Private access to AWS services through VIF 
- Bypass ISP, reduce network cost, increase bandwidth and stability
- Not redundant by default (must setup a failover DX or VPN)

#### Direct Connect Virtual Interfaces (VIF) 

- Public VIF: connect to Public AWS Endpoints (S3 buckets, EC2 service, anything AWS …) 
- Private VIF: connect to resources in your VPC (EC2 instances, ALB, …) 
- Transit Virtual Interface: connect to resources in a VPC using a Transit Gateway 

**Note: VPC Interface Endpoints can be accessed through Private VIF**

