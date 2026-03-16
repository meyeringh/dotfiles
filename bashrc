# dotfiles bashrc - sourced from ~/.bashrc

# VPN
alias vpn-up='~/git/dotfiles/scripts/vpn-up.sh'
alias vpn-down='~/git/dotfiles/scripts/vpn-down.sh'
alias vpn-status='~/git/dotfiles/scripts/vpn-status.sh'
alias vpn-log='sudo tail -f /tmp/openvpn.log'

# Scripts
export PATH="$HOME/git/dotfiles/scripts:$PATH"
