#!/bin/bash

# Flush iptables rules
iptables -F

### INPUT ###
# Accept already established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept from loopback
iptables -A INPUT -i lo -j ACCEPT

# Accept new and established connection from TCP port 80
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Reject anything else
iptables -A INPUT -j REJECT


### OUTPUT ###
# Accept already established connections
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Accept to loopback
iptables -A OUTPUT -o lo -j ACCEPT

# Accept established from TCP port 80
iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Reject anything else
iptables -A OUTPUT -j REJECT

# Log Settings
iptables -N LOGDROP
iptables -A logdrop -J LOG
iptables -A logdrop -J DROP
