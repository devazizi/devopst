#!/bin/bash

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Clear existing rules
iptables -F
iptables -t nat -F

# Default policies
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Add NAT rules for VPN traffic
iptables -t nat -A POSTROUTING -s 10.13.13.0/24 -o eth0 -j MASQUERADE  # WireGuard subnet
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE    # OpenVPN subnet
iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE # Local network

# Allow VPN protocols
iptables -A INPUT -p udp --dport 51820 -j ACCEPT  # WireGuard
iptables -A INPUT -p udp --dport 1194 -j ACCEPT   # OpenVPN UDP
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT   # OpenVPN TCP

# Allow forwarding between all interfaces
iptables -A FORWARD -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Save iptables rules
if command -v iptables-save >/dev/null 2>&1; then
    iptables-save > /etc/iptables/rules.v4
fi

# Add static routes if needed
ip route add 192.168.100.0/24 via 192.168.100.43 || true
ip route add 10.8.0.0/24 dev tun0 || true
ip route add 10.13.13.0/24 dev wg0 || true

echo "Network configuration completed successfully!" 