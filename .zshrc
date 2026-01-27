# Determine dotfiles profile
if [[ -f ~/dotfiles_profile ]]; then
  export DOTFILES_PROFILE=$(cat ~/dotfiles_profile)
else
  export DOTFILES_PROFILE="home"
fi

# Path to dotfiles directory
export DOTFILES_DIR="$HOME/dotfiles"

# 1. Load Common ZSH Config
source "$DOTFILES_DIR/zsh/common.zsh"

# 2. Load Profile Specific ZSH Config
if [[ -f "$DOTFILES_DIR/zsh/$DOTFILES_PROFILE.zsh" ]]; then
  source "$DOTFILES_DIR/zsh/$DOTFILES_PROFILE.zsh"
fi

# 3. Load Common Aliases
source "$DOTFILES_DIR/aliases/common.zsh"

# 4. Load Profile Specific Aliases
if [[ -f "$DOTFILES_DIR/aliases/$DOTFILES_PROFILE.zsh" ]]; then
  source "$DOTFILES_DIR/aliases/$DOTFILES_PROFILE.zsh"
fi
