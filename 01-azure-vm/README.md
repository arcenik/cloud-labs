# Testing Azure Virtual Machine

## Deploy

```sh
$ tofu init
$ tofu apply

...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

vm_public_ip = "51.103.165.172"

$ tofu state list
azurerm_network_interface.test1
azurerm_public_ip.test1
azurerm_resource_group.main
azurerm_subnet.main
azurerm_virtual_machine.test1
azurerm_virtual_network.main
```

## Using

```sh
$ ssh 51.103.165.172
The authenticity of host '51.103.165.172 (51.103.165.172)' can't be established.
ED25519 key fingerprint is SHA256:iE/KbxxaNv50CdUMoYFTEWYL8mxo1/vdfAacCp1xz6M.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.103.165.172' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 6.5.0-1022-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Tue Jun 25 13:39:18 UTC 2024

  System load:  0.15              Processes:             112
  Usage of /:   5.1% of 28.89GB   Users logged in:       0
  Memory usage: 14%               IPv4 address for eth0: 10.0.0.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

fs@test1:~$
```

## Destroy

```sh
$ tofu destroy
```
