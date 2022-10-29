#!/bin/bash
#lab3
#use the which command to see whether lxd is already installed or not
which lxd >/dev/null
if [ $? -ne 0 ]; then
#installing the lxd
	echo "Installing the lxd by entering the pass"
	sudo snap install lxd
	if [ $? -ne 0 ]; then
#failed to install lxd
		echo "lxd is failed to install on the system."
		exit 1
	fi
fi
#for interface lxdbr0
ip a s | grep -w lxdbr0
if [ $? -ne 0 ]; then
	lxd init --auto
#failed to install lxdbr0 interface
	if [ $? -ne 0 ]; then
		echo "lxdbr0 interface failed"
		exit 1
	fi
fi
#launching container in lxd
lxc launch ubuntu:20.04 COMP2101-S22
#add or update the entry in /etc/hosts for hostname COMP2101-S22 with the container’s current IP address
#lxc list command to show the container
lxc list
IP=$(lxc list | grep -w IPV4 -v | awk '{print $6}')
sudo -- sh -c "echo '$IP' COMP2101-S22 >> /etc/hosts"
#installing apache2 server 
lxc exec COMP2101-S22 -- apt update
lxc exec COMP2101-S22 -- apt install apache2
lxc exec COMP2101-S22 -- systemctl start apache2
#use the curl command whether it is working or not
curl http://comp2101-s22/
if [ $? -eq 0 ]; then
	echo "successfull"
	exit 0 
else 
	echo "failed"
	exit 1
fi
