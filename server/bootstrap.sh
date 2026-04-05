#!/bin/bash
# One-time bootstrap for a fresh Ubuntu 24.04 server (run as root)
set -eo pipefail

USERNAME="lee"
DOTFILES_REPO="https://github.com/8888/dotfiles.git"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Run this script as root${NC}"
    exit 1
fi

echo -e "${GREEN}Bootstrapping server for Claude Code remote access${NC}"

# --- System packages ---
echo -e "${BLUE}Updating system and installing packages...${NC}"
apt-get update
apt-get install -y \
    git curl wget jq tmux zsh build-essential ripgrep unzip \
    software-properties-common

# Install GitHub CLI
if ! command -v gh &> /dev/null; then
    echo -e "${BLUE}Installing GitHub CLI...${NC}"
    (type -p wget >/dev/null || apt-get install wget -y) \
        && mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat "$out" | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
        && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && apt-get update \
        && apt-get install gh -y
fi

# Install bat (Ubuntu packages it as 'batcat')
if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
    ln -sf $(which batcat) /usr/local/bin/bat
fi

# Install eza
if ! command -v eza &> /dev/null; then
    echo -e "${BLUE}Installing eza...${NC}"
    apt-get install -y gpg
    mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list
    chmod 644 /etc/apt/keyrings/gierens.gpg
    apt-get update
    apt-get install -y eza
fi

# Install Tailscale
if ! command -v tailscale &> /dev/null; then
    echo -e "${BLUE}Installing Tailscale...${NC}"
    curl -fsSL https://tailscale.com/install.sh | sh
fi

# --- User setup ---
if ! id "$USERNAME" &>/dev/null; then
    echo -e "${BLUE}Creating user ${USERNAME}...${NC}"
    useradd -m -s $(which zsh) -G sudo "$USERNAME"
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}

    # Copy SSH keys from root
    mkdir -p /home/${USERNAME}/.ssh
    cp /root/.ssh/authorized_keys /home/${USERNAME}/.ssh/authorized_keys
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
    chmod 700 /home/${USERNAME}/.ssh
    chmod 600 /home/${USERNAME}/.ssh/authorized_keys
else
    echo -e "${BLUE}User ${USERNAME} already exists.${NC}"
    # Ensure zsh is the default shell
    chsh -s $(which zsh) ${USERNAME}
fi

# --- User-level setup (run as the target user) ---
echo -e "${BLUE}Setting up ${USERNAME} environment...${NC}"
su - ${USERNAME} -c "bash -c '
set -eo pipefail

# Install Oh My Zsh
if [ ! -d \"\$HOME/.oh-my-zsh\" ]; then
    echo \"Installing Oh My Zsh...\"
    sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended --keep-zshrc
fi

# Install Oh My Zsh plugins & themes
ZSH_CUSTOM=\${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}

if [ ! -d \"\$ZSH_CUSTOM/plugins/zsh-autosuggestions\" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \"\$ZSH_CUSTOM/plugins/zsh-autosuggestions\"
fi

if [ ! -d \"\$ZSH_CUSTOM/plugins/zsh-syntax-highlighting\" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \"\$ZSH_CUSTOM/plugins/zsh-syntax-highlighting\"
fi

if [ ! -d \"\$ZSH_CUSTOM/themes/powerlevel10k\" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \"\$ZSH_CUSTOM/themes/powerlevel10k\"
fi

# Install mise
if ! command -v mise &> /dev/null && [ ! -f \"\$HOME/.local/bin/mise\" ]; then
    echo \"Installing mise...\"
    curl https://mise.run | sh
fi

# Install uv
if ! command -v uv &> /dev/null && [ ! -f \"\$HOME/.local/bin/uv\" ]; then
    echo \"Installing uv...\"
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install Node.js via mise
export PATH=\"\$HOME/.local/bin:\$PATH\"
if ! mise which node &> /dev/null 2>&1; then
    echo \"Installing Node.js via mise...\"
    mise install node@lts
    mise use --global node@lts
fi

# Install Claude Code
eval \"\$(mise activate bash)\"
if ! command -v claude &> /dev/null; then
    echo \"Installing Claude Code...\"
    npm install -g @anthropic-ai/claude-code
fi

# Clone dotfiles
if [ ! -d \"\$HOME/dotfiles\" ]; then
    echo \"Cloning dotfiles...\"
    git clone ${DOTFILES_REPO} \"\$HOME/dotfiles\"
fi

# Run install script
echo \"Running dotfiles install...\"
\$HOME/dotfiles/install.sh server
'"

# --- Tailscale ---
echo ""
echo -e "${GREEN}Bootstrap complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Set up Tailscale:  sudo tailscale up"
echo "  2. SSH in as ${USERNAME}:  ssh ${USERNAME}@<tailscale-ip>"
echo "  3. Authenticate Claude:  claude login"
echo "  4. Authenticate GitHub:  gh auth login"
echo "  5. Set up credentials:  cp ~/dotfiles/.credentials.example ~/.credentials && vi ~/.credentials"
echo "  6. Clone projects:  cd ~/projects && gh repo clone 8888/<repo-name>"
