# Auto-attach to tmux on SSH login (must run before p10k instant prompt)
if [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] && [[ $- == *i* ]] && tty -s; then
  exec tmux new-session -A -s main
fi

# Enable Powerlevel10k instant prompt (must be at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Determine dotfiles profile
if [[ -f ~/.dotfiles_profile ]]; then
  export DOTFILES_PROFILE=$(cat ~/.dotfiles_profile)
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

# To customize prompt, run `p10k configure` or edit ~/dotfiles/p10k.zsh.
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh
