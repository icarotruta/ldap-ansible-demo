# Ansible Playbook for Initial LDAP Setup

## 1. What is it?

This is a demonstration how to automate a simple (and single) LDAP server deployment and also integrate another instance as a client.
This playbook can be used to deploy both on bare metal machines and cloud-based instances such as Nova Instances (Openstack) and EC2 instances (AWS).

## 2. Install Ansible

From the machine you are gonna run the playbooks, do:

```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
#if you are going to use the aws modules you will need to install boto and boto3
sudo apt install -y boto boto3
```

For more details on the Ansible installation, check this [link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu).
As for the EC2 instances manipulation you can check this [link](https://docs.ansible.com/ansible/2.3/ec2_module.html)

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
ansible-playbook services-deploy.yml -b
```

Alternatively, you can add the parameter -vvv to better understandment of the "behind the scenes".

## 5. Checking the deployment

To check if the instalation worked as expected, try to access a client machine and run the command below:

```ini
getent passwd
```


## 6. Running (wild) on AWS EC2 instances

First we need to prepare some of the infrastructure at the AWS Console, such as:

* One IAM user with ec2 privilegies;
* A ssh key for login after the deployment;
* A VPC;
* A security group with the TCP ports 22, 389(this one can be only for the subnet hosts itself)  accepting inbound traffics.

Now, we can update the env_vars file with the necessary values and run the e2-deploy playbook:

```ini
ansible-playbook ec2-infra-deploy.yml
```

After the playbook finish, you can check the instances both at the AWS console and accessing via ssh with the keypair selected.

### Using the Post EC2 Deployment script

On the post-deployment folder, you can run the change-hosts.sh script to update the hosts file and also change the ldap server IP address. To do this, follow this steps:
```ìni
cd post-ec2-scripts
chmod +x change-hosts.sh
./change-hosts.sh <server public ip> <server subnet ip> <client public ip>
#if you forget the args, just check again here  
```

After this, just run the conventional playbook!

```ini
ansible-playbook services-deploy.yml -b
```


## Disclaimer

This demo is for testing use only, it may not work properly on a production environment.
For this demo, the operational system used was the Ubuntu 20.04 server both at Openstack an AWS.
