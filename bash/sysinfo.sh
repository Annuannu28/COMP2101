#!/bin/bash
# My challenge script - sysinfo.sh
# Embedded variables for report data

FQDN1=$(hostname)
OS_NAME=$(cat /etc/os-release | grep -w NAME)
VERSION_NAME=$(cat /etc/os-release | grep -w VERSION)
IP_ADD=$(ip a s enp0s8 | grep -w inet | awk '{print $2}')
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



