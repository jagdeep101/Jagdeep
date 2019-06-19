#!/bin/bash
#
# this script displays some host identification information for a Linux machine
#
# Sample output:
#   Hostname      : zubu
#   LAN Address   : 192.168.2.2
#   LAN Name      : net2-linux
#   External IP   : 1.2.3.4
#   External Name : some.name.from.our.isp
# the LAN info in this script uses a hardcoded interface name of "eno1"
#    - change eno1 to whatever interface you have and want to gather info about in order to test the script
# TASK 1: Dynamically identify the list of interface names for the computer running the script, and use a for loop to generate the report for every interface except loopback
################
# Data Gathering
################
# grep is used to filter ip command output so we don't have extra junk in our output
# stream editing with sed and awk are used to extract only the data we want displayed
# we use the hostname command to get our system name

my_hostname=$(hostname)

# the default route can be found in the route table normally
# the router name is obtained with getent

default_router_address=$(ip r s default| cut -d ' ' -f 3)
default_router_name=$(getent hosts $default_router_address|awk '{print $2}')

# finding external information relies on curl being installed and relies on live internet connection

external_address=$(curl -s icanhazip.com)
external_name=$(getent hosts $external_address | awk '{print $2}')

cat <<EOF
System Identification Summary
=============================
Hostname      : $my_hostname
Default Router: $default_router_address
Router Name   : $default_router_name
External IP   : $external_address
External Name : $external_name
EOF

# Define the interface being summarized
# interface=$( ls -l /sys/class/net/ | awk '{print $9}')
# loopback: sudo ifconfig lo:10 127.0.0.2 netmask 255.0.0.0 up
# Find an address and hostname for the interface being summarized
# we are assuming there is only one IPV4 address assigned to this interface
# Identify the network number for this interface and its name if it has one

count=$(lshw -class network | awk '/logical name:/{print $3}' | wc -l)
for((w=1; w<=$count; w+=1));
do
  interface=$(lshw -class network |
    awk '/logical name:/{print $3}' |
      awk -v z=$w 'NR==z{print $1; exit}')
  if [[ $interface = lo* ]] ; then continue ; fi

  lan_addr=$(ip a s $interface | awk -F '[/ ]+' '/inet /{print $3}')
  lan_name=$(getent hosts $lan_addr | awk '{print $2}')
  net_addr=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
  net_num=$(cut -d / -f 1 <<<"$net_addr")
  net_name=$(getent networks $net_num|awk '{print $1}')

cat <<- EOF
Interface $interface:
===============
Address         : $lan_addr
Name            : $lan_name
Network Address : $net_addr
Network Name    : $net_name

EOF

done
