from aws_cdk import (
    # Duration,
    Stack,
    aws_ec2 as ec2
)
from constructs import Construct
import os

class PythonStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        region = "eu-central-1"
        az1 = region + "a"

        vpc = ec2.Vpc(self, "test1-vpc",
            ip_addresses = ec2.IpAddresses.cidr("10.0.0.0/16"),
            availability_zones = [ az1 ],
            create_internet_gateway = True,
            subnet_configuration = [
                ec2.SubnetConfiguration(
                    name = "test1-subnet",
                    cidr_mask = 24,
                    map_public_ip_on_launch = True,
                    subnet_type = ec2.SubnetType.PUBLIC,
                ),
            ],
        )

        kp = ec2.KeyPair(self, "keypair",
            key_pair_name = "test1-keypair",
            public_key_material = os.environ["SSHPUBKEY"]
        )

        sg = ec2.SecurityGroup(self, "test1-sg", vpc=vpc)
        sg.add_ingress_rule(ec2.Peer.ipv4("0.0.0.0/0"), ec2.Port.SSH, "SSH access")

        instance = ec2.Instance(self, "targetInstance",
            vpc = vpc,
            instance_type = ec2.InstanceType.of(ec2.InstanceClass.BURSTABLE2, ec2.InstanceSize.MICRO),
            machine_image = ec2.AmazonLinuxImage(generation = ec2.AmazonLinuxGeneration.AMAZON_LINUX_2),
            key_pair = kp,
            security_group = sg,
        )
