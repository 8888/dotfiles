# dotfiles

## todo, steps that are missing
- Install homebrew
```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
- Install git
```zsh
brew install git
```
- Clone .dotfiles
```zsh
git clone git@github.com:8888/dotfiles.git ~/.dotfiles
```
- Install oh-my-zsh
```zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
- Install powerlevel10k for oh-my-zsh
```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
- Install zsh-autosuggestions plugin
```zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```
- Install font "MesloLGS NF". Run the p10k configure command, but do not go through all the steps. Or just reset changes to `.p10k.zsh` if it makes cahnges.
```zsh
p10k configure
```
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
- Create ~/.pgpass since this isn't version controlled
```zsh
localhost:5432:<dbname>:<user>:<password>
```
