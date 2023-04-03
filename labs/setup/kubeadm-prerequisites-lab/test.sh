#!/usr/bin/bash


Gather info from controller
printf "\ncontroller\n----------------\n" > linux_hosts
ssh controller hostnamectl >> linux_hosts
ssh controller lscpu | grep ^CPU\(s\): >> linux_hosts
ssh controller grep MemTotal /proc/meminfo >> linux_hosts
ssh controller cat /proc/meminfo | grep SwapCached: >> linux_hosts
ssh controller ip l | grep link/ether >> linux_hosts
# Gather same info, but target node-1
printf "\nnode-1\n----------------\n" >> linux_hosts
ssh node-1 hostnamectl >> linux_hosts
ssh node-1 lscpu | grep ^CPU\(s\): >> linux_hosts
ssh node-1 grep MemTotal /proc/meminfo >> linux_hosts
ssh node-1 cat /proc/meminfo | grep SwapCached: >> linux_hosts
ssh node-1 ip l | grep link/ether  >> linux_hosts
# Gather same info, but target node-3
printf "\nnode-2\n----------------\n" >> linux_hosts
ssh node-2 hostnamectl >> linux_hosts
ssh node-2 lscpu | grep ^CPU\(s\): >> linux_hosts
ssh node-2 grep MemTotal /proc/meminfo >> linux_hosts
ssh node-2 cat /proc/meminfo | grep SwapCached:  >> linux_hosts
ssh node-2 ip l | grep link/ether  >> linux_hosts

hostnamectl
ssh controller hostnamectl
ssh controller lscpu | grep ^CPU\(s\):
ssh controller cat /proc/meminfo
ssh controller cat /proc/meminfo | grep SwapTotal:
cat /proc/meminfo | grep SwapTotal:
ssh controller ip link
ssh controller ip link | grep link/ether
ssh node-1 ip link | grep link/ether
ssh node-2 ip link | grep link/ether


