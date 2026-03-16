#!/bin/bash
sudo pkill openvpn 2>/dev/null && echo "VPN disconnected" || echo "VPN not running"
