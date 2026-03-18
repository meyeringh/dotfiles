# dotfiles bashrc - sourced from ~/.bashrc

# VPN
alias vpn-up='~/git/dotfiles/scripts/vpn-up.sh'
alias vpn-down='~/git/dotfiles/scripts/vpn-down.sh'
alias vpn-status='~/git/dotfiles/scripts/vpn-status.sh'
alias vpn-log='sudo tail -f /tmp/openvpn.log'

# Scripts
export PATH="$HOME/git/dotfiles/scripts:$PATH"

# Eternal bash history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Git prompt
if [ -f "$HOME/git/bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/git/bash-git-prompt/gitprompt.sh"
fi

# Ansible
export ANSIBLE_VAULT_PASSWORD_FILE=~/git/dotfiles/scripts/ansible-vault-pass.sh
export ANSIBLE_BECOME_PASSWORD_FILE=~/git/dotfiles/scripts/ansible-become-pass.sh
export ANSIBLE_CONNECTION_PASSWORD_FILE=~/git/dotfiles/scripts/ansible-connection-pass.sh
