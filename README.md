# dotfiles

git clone git@github.com:8888/dotfiles.git ~/.dotfiles
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
run `p10k configure` to install fonts, but do not go through all the steps to create a new `.p10k.zsh`
. ~/.dotfiles/install.sh
create real `./expo_credentials` based off of `.expo_credentials.exmaple`
