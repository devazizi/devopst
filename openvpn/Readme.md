### Initialize OpenVPN Configuration
docker compose run --rm openvpn ovpn_genconfig -u udp://YOUR_PUBLIC_IP
docker compose run --rm openvpn ovpn_initpki

### Create a Client Profile
docker compose run --rm openvpn easyrsa build-client-full CLIENT_NAME nopass
docker compose run --rm openvpn ovpn_getclient CLIENT_NAME > CLIENT_NAME.ovpn

echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
<!-- 
### Iptables to access NAT
sudo iptables -t nat -A POSTROUTING -s 192.168.255.0/24 -d 192.168.100.0/24 -j MASQUERADE
sudo iptables -A FORWARD -s 192.168.255.0/24 -d 192.168.100.0/24 -j ACCEPT
sudo iptables -A FORWARD -s 192.168.100.0/24 -d 192.168.255.0/24 -j ACCEPT -->
