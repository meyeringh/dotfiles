#!/bin/bash
set -euo pipefail

# bash-git-prompt
if [ ! -d "$HOME/.bash-git-prompt" ]; then
    echo "Installing bash-git-prompt..."
    git clone https://github.com/magicmonty/bash-git-prompt.git "$HOME/.bash-git-prompt" --depth=1
fi

echo "Setup complete. Run: source ~/.bashrc"
