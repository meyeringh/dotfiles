# dotfiles bashrc - sourced from ~/.bashrc

# VPN
alias vpn-up='~/dotfiles/scripts/vpn-up.sh'
alias vpn-down='~/dotfiles/scripts/vpn-down.sh'
alias vpn-status='~/dotfiles/scripts/vpn-status.sh'
alias vpn-log='tail -f /tmp/openvpn.log'

# Scripts
export PATH="$HOME/dotfiles/scripts:$PATH"
