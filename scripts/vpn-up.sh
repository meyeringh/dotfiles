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
    GW=217.10.69.1
    # sipgate internal routes (from PUSH_REPLY)
    for route in \
        217.10.64.0/20 \
        212.9.32.0/19 \
        217.116.112.0/20 \
        82.116.96.0/19 \
        95.174.128.0/19 \
        92.79.62.192/26 \
        192.109.199.0/24 \
        34.98.92.3/32 \
        10.11.0.0/16 \
        10.13.0.0/16 \
        10.14.0.0/16 \
        10.16.0.0/12 \
        10.42.0.0/15 \
        10.50.0.0/16 \
        10.60.0.0/16 \
        10.70.0.0/16 \
        10.80.0.0/16 \
        10.90.0.0/16 \
        10.183.158.5/32 \
        134.119.225.122/32 \
        217.10.68.69/32 \
        217.10.68.68/32; do
        sudo ip route add "$route" via "$GW" dev tun0 2>/dev/null || true
    done
    echo "VPN connected (split-tunnel, $(echo "$route" | wc -w) routes via $GW)"
else
    echo "VPN failed to start. Check: vpn-log"
fi
