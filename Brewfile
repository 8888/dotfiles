# Core Tools
brew "git"
brew "gh"
brew "jq"
brew "wget"

# Cloud & Infrastructure
brew "awscli"

# Runtimes
brew "mise"
brew "uv"

# Apps
cask "visual-studio-code"
cask "wezterm"
cask "docker-desktop"
cask "tableplus"
cask "obsidian"

# Document Processing
brew "pandoc"
cask "basictex"

# AI
brew "skills"
brew "googleworkspace-cli"

# Agent Orchestration (Gas City runtime deps; gc itself is built from source, not Homebrew)
brew "dolt"
# beads (bd) is VERSION-PINNED — do NOT let brew upgrade drift it.
# Mac + VM must run the SAME bd schema version (1.0.5+, split dependency schema).
# Enforced via `brew pin beads`; the VM pins the matching gastownhall release in
# agentic-factory/docnow-mobile/scripts/vm-standup.sh (REQUIRED_BD_VERSION). A
# mismatch silently breaks every dependency query (2026-06-01 cascade).
brew "beads"  # PINNED — run `brew unpin beads` only when bumping BOTH hosts in lockstep
brew "tmux"
brew "flock"

# Tools
brew "gitleaks"
brew "bat"
brew "eza"
cask "font-geist-mono-nerd-font"
cask "font-jetbrains-mono-nerd-font"
cask "ngrok"
