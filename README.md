# dotfiles

## Setup
1. **Configure SSH for GitHub**: [GitHub Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
2. **Clone dotfiles**:
   ```zsh
   git clone git@github.com:8888/dotfiles.git ~/dotfiles
   ```
3. **Run Installation**:
   The script will automatically install Homebrew, Oh My Zsh, plugins, Git, AWS CLI, and VS Code.
   ```zsh
   # For a home computer
   ~/dotfiles/install.sh home

   # For a work computer
   ~/dotfiles/install.sh work
   ```
4. **Finalize**:
   - Create real `./expo_credentials` based off of `.expo_credentials.example`.
   - Setup `~/.pgpass` if needed (see below).

## Manual steps
- Create ~/.pgpass since this isn't version controlled (set correct permissions `chmod 0600 ./.pgpass`)
```zsh
localhost:5432:<dbname>:<user>:<password>
```
