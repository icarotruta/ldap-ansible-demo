# Ansible Playbook for Initial LDAP Setup

## 1. What is it?

xpto-for-the-win

## 2. Install Ansible

From the machine you are gonna run the playbooks, do:

```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

For more details on the Ansible installation, check this [link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu).

## 3. Setup the required configuration

## Hosts file

Ansible needs to know which hosts it gonna work into, in this example project, the hosts are divided into 2 groups: servers and clients. The configuration should be like this:

```ini
[servers]
#servers ip addresses
aa.bb.cc.dd

[clients]
#clients ip addresses
ee.ff.gg.hh
```

## SSH access

To have an easy access to the host inventory, it is possible to add the ssh-key path in the ansible.cnf file as the default ssh-key and run the playbook normally as it shows below:

```ini
(...)
# if set, always use this private key file for authentication, same as
# if passing --private-key to ansible or ansible-playbook
private_key_file = /path/to/file
```
## Running the playbook

After the changes are made, you can run the playbook as it shows below:

```ini
ansible-playbook setup-hosts.yml -b
```

Alternatively, you can add the parameter -vvv to better understandment of the "behind the scenes".

## 5. Checking the deployment

To check if the instalation worked as expected, try to access a client machine and run the command below:

```ini
getent passwd
```

