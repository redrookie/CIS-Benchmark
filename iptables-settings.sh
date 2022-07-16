#!/bin/bash

# Flush iptables rules
iptables -F
iptables -X

#Loopback Traffic Settings
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j DROP

# Log Settings
iptables -N LOGDROP
iptables -A LOGDROP -j LOG
iptables -A LOGDROP -j DROP
