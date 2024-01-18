# dotfiles

## todo, steps that are missing
- Install homebrew
```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)
```
- Install git
```zsh
brew install git
```
- Configure ssh for git: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
- Clone .dotfiles
```zsh
git clone git@github.com:8888/dotfiles.git ~/.dotfiles
```
- Install oh-my-zsh
```zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
- Install powerlevel10k for oh-my-zsh, MesloLGS NF font,
  - https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation
- Install zsh-autosuggestions plugin
```zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```
- Install VS Code
- Setup symbolic links
```zsh
. ~/.dotfiles/install.sh
```
- create real `./expo_credentials` based off of `.expo_credentials.example`
- Install aws cli 2
```zsh
brew install awscli
```

## Manual steps
- Create ~/.pgpass since this isn't version controlled (set correct permissions `chmod 0600 ./.pgpass`)
```zsh
localhost:5432:<dbname>:<user>:<password>
```
