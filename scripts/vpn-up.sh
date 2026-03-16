#!/bin/bash
set -euo pipefail
CREDS="$HOME/.vpn-creds"
if [ ! -s "$CREDS" ]; then
    echo "Fetching VPN credentials from 1Password..."
    USER=$(op item get LDAP --fields label=username --reveal)
    PASS=$(op item get LDAP --fields label=password --reveal)
    printf '%s\n%s\n' "$USER" "$PASS" > "$CREDS"
    chmod 600 "$CREDS"
fi
sudo openvpn --config /etc/openvpn/sipgate.conf \
    --auth-user-pass "$CREDS" \
    --route-nopull \
    --daemon --log /tmp/openvpn.log
sleep 3
if pgrep openvpn > /dev/null; then
    # add only sipgate internal routes through the VPN tunnel
    VPN_GW=$(awk '/route_vpn_gateway/{print $2}' /tmp/openvpn.log | tail -1)
    if [ -n "$VPN_GW" ]; then
        sudo ip route add 10.0.0.0/8 via "$VPN_GW" dev tun0 2>/dev/null || true
        sudo ip route add 172.16.0.0/12 via "$VPN_GW" dev tun0 2>/dev/null || true
        echo "VPN connected (split-tunnel via $VPN_GW)"
    else
        echo "VPN connected but could not determine gateway. Check: vpn-log"
        echo "Add routes manually: sudo ip route add 10.0.0.0/8 via <gw> dev tun0"
    fi
else
    echo "VPN failed to start. Check: vpn-log"
fi
