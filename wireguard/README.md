# WireGuard Docker Setup

This setup provides a WireGuard VPN server running in Docker with access to the NAT network (192.168.100.0/24).

## Prerequisites

- Docker
- Docker Compose
- Linux kernel with WireGuard support (usually included in kernel 5.6+)

## Setup Instructions

1. Make sure WireGuard kernel module is loaded:
   ```bash
   sudo modprobe wireguard
   ```

2. Start the WireGuard container:
   ```bash
   docker-compose up -d
   ```

3. Get the client configuration:
   The client configuration will be generated in the `config/peer1` directory. You can use this configuration with any WireGuard client.

## Configuration Details

- Server Port: 51820 (UDP)
- Internal VPN Subnet: 10.13.13.0/24
- Container IP: 192.168.100.100
- Allowed IPs: 192.168.100.0/24

## Client Setup

1. Install WireGuard client on your device
2. Copy the contents of `config/peer1/peer1.conf` to your client
3. Import the configuration into your WireGuard client
4. Connect to the VPN

## Security Notes

- Keep your configuration files private
- The peer configuration contains private keys
- Change the SERVERURL environment variable to your public IP or domain

## Troubleshooting

If you experience connection issues:
1. Check if the WireGuard module is loaded: `lsmod | grep wireguard`
2. Verify the container logs: `docker-compose logs -f`
3. Check your firewall settings for UDP port 51820 