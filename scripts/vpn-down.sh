#!/bin/bash
sudo killall openvpn 2>/dev/null && echo "VPN disconnected" || echo "VPN not running"
