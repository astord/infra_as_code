## Resources description

Region: eu-west-1 / IRL

- 1 TGW
- 2 VPCs
    - AZs: A + B
    - public subnets
    - private subnets
    - TGW attachments
- 2 EC2 in the private subnets
    - SSM login - enabgled

Traffic flow:

EC1@VPC1 -> Private-NAT-GW@VPC1 -> TGW -> EC2@VPC2
