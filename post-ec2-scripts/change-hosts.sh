#!/bin/bash
SERVER_IP=$1
SERVER_privIP=$2
CLIENT_IP=$3

#Usage: ./change-hosts.sh <server public ip> <server private ip> <client ip>

echo "Copy host file"
cp hosts-example new-hosts
echo "Changing server ip"
sed -i "s/10.0.0.1/$SERVER_IP/g" new-hosts

echo "Changing client ip"
sed -i "s/10.0.0.2/$CLIENT_IP/g" new-hosts
echo "Updating hosts file"
cat new-hosts > ../hosts

echo "changing ldap client files"
cp ldap-base.conf ldb.cnf
cp nslcd-base.conf nsl.cnf
sed -i "s/10.0.0.1/$SERVER_privIP/g" ldb.cnf
sed -i "s/10.0.0.1/$SERVER_privIP/g" nsl.cnf
cat ldb.cnf > ../playbooks/roles/clients/files/ldap-base.conf
cat nsl.cnf > ../playbooks/roles/clients/files/nslcd-base.conf

echo "Removing unused files"
rm new-hosts ldb.cnf nsl.cnf
echo "Done."
