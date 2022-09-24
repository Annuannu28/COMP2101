#!/bin/bash
# My challenge script - sysinfo.sh
# The system’s fully-qualified domain name (FQDN)
hostname -A

# The operating system name and version
hostnamectl

# Showing the IP addresses
hostname -I

# Space available in only the root filesystem
df -h /
