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
sudo openvpn --config /etc/openvpn/sipgate.conf --auth-user-pass "$CREDS" --pull-filter ignore redirect-gateway --daemon --log /tmp/openvpn.log
sleep 2
if pgrep openvpn > /dev/null; then
    echo "VPN connecting... check vpn-log for details"
else
    echo "VPN failed to start. Check: vpn-log"
fi
