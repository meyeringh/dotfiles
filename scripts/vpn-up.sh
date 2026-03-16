#!/bin/bash
CREDS="$HOME/.vpn-creds"
if [ ! -f "$CREDS" ]; then
    echo "Fetching VPN credentials from 1Password..."
    op item get LDAP --fields label=username --reveal > "$CREDS"
    op item get LDAP --fields label=password --reveal >> "$CREDS"
    chmod 600 "$CREDS"
fi
sudo openvpn --config /etc/openvpn/sipgate.conf --auth-user-pass "$CREDS" --daemon --log /tmp/openvpn.log
echo "VPN connecting... check with vpn-status"
