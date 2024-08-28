import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Environment } from 'aws-cdk-lib/aws-appconfig';

export class TsStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const region = 'eu-central-1';
    const az1 = region + 'a';

    const vpc = new ec2.Vpc(this, 'test1-vpc', {
      ipAddresses: ec2.IpAddresses.cidr('10.0.0.0/16'),
      availabilityZones: [az1],
      createInternetGateway: true,
      vpcName: 'test1-vpc',
      subnetConfiguration: [
        {
          name: 'test1-subnet-public',
          subnetType: ec2.SubnetType.PUBLIC
        },
      ],
    });

    // const subnet = new ec2.Subnet(this, 'test1-subnet', {
    //   vpcId: vpc.vpcId,
    //   availabilityZone: az1,
    //   cidrBlock: '10.0.0.0/24',
    // });

    const kp = new ec2.KeyPair(this, 'test1-keypair', {
      keyPairName: 'test1-fs-keypair',
      publicKeyMaterial: process.env.SSHPUBKEY,
    });

    const sg = new ec2.SecurityGroup(this, 'test1-sg', {
      vpc: vpc,
      allowAllOutbound: true,
    });
    sg.addIngressRule(ec2.Peer.anyIpv4(), ec2.Port.tcp(22), 'Allow SSH access');

    const instance = new ec2.Instance(this, 'test1-vm', {
      vpc: vpc,
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.BURSTABLE3_AMD, ec2.InstanceSize.MICRO),
      machineImage: ec2.MachineImage.latestAmazonLinux2023(),
      keyPair: kp,
      securityGroup: sg,
      associatePublicIpAddress: true,
    });

  }
}
