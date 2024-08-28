# Testing Azure Virtual Machine

## Deploy

```sh
$ tofu init
$ time tofu apply -auto-approve

...

aws_instance.test1: Still creating... [10s elapsed]
aws_instance.test1: Creation complete after 12s [id=i-08b28a7239f3e6eb7]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_public_ip = "18.185.65.102"
tofu apply -auto-approve  3.42s user 0.72s system 15% cpu 26.299 total

$ tofu state list
data.aws_ami.ubuntu
aws_instance.test1
aws_internet_gateway.main
aws_key_pair.test1
aws_route_table.main
aws_route_table_association.main
aws_security_group_rule.ssh
aws_subnet.main
aws_vpc.main
```

## Using

```sh
$ ssh admin@18.185.65.102
Linux ip-10-0-0-41 6.1.0-13-cloud-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1 (2023-09-29) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Aug 28 08:37:21 2024 from 82.197.179.80
admin@ip-10-0-0-41:~$ 
```

## Destroy

```sh
$ time tofu destroy -auto-approve

...

aws_subnet.main: Destruction complete after 1s
aws_vpc.main: Destroying... [id=vpc-0f21f592a685f8ddb]
aws_vpc.main: Destruction complete after 0s

Destroy complete! Resources: 8 destroyed.
tofu destroy -auto-approve  4.58s user 0.76s system 9% cpu 55.840 total
```
