#!/bin/bash
pgrep openvpn > /dev/null && echo "connected" || echo "disconnected"
