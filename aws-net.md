# AWS Networking

- AWS networking

### Virtual Private Cloud (VPC)

- A VPC is a logically isolated network in AWS where you can launch AWS resources.

```bash
# create vpc
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Creating Subnets:
aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 10.0.1.0/24

# Associating a Route Table with a Subnet. 
aws ec2 associate-route-table --subnet-id <subnet-id> --route-table-id <route-table-id>


# Creating a Route in the route table
aws ec2 create-route --route-table-id <route-table-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <igw-id>

```

### Route Tables and Internet Gateways

- Route tables control the routing of traffic within your VPC. Internet gateways enable internet access for your VPC.

```bash
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --vpc-id <vpc-id> --internet-gateway-id <igw-id>
aws ec2 create-route-table --vpc-id <vpc-id>

```
