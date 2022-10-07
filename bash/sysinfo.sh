#!/bin/bash
# My challenge script - sysinfo.sh
# Embedded variables for report data

#the fully qualified domain name
FQDN1=$(hostname)

#The operating system name and version
OS_NAME=$(cat /etc/os-release | grep -w NAME)
VERSION_NAME=$(cat /etc/os-release | grep -w VERSION)

#IP address used by the computer 
IP_ADD=$(ip a s enp0s8 | grep -w inet | awk '{print $2}')

#the root filesystem space line
Filesystem_Freespace=$(df -h  --output=avail / | grep Avail -v)

# print out the report using the gathered data
cat <<EOF
Report for myvm
===============
FQDN: $FQDN1
Operating system name and version: $OS_NAME/$VERSION_NAME
IP Address: $IP_ADD
Root Filesystem Free Space: $Filesystem_Freespace
============== 
EOF



