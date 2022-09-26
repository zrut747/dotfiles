#! /usr/bin/env zsh

DOTDIR=~/.dotfiles
DOT_GITHUB_MIRROR=${DOT_GITHUB_MIRROR:-"https://github.com"}

# source init.sh
touch ~/.zshrc
sed -i "\:$DOTDIR/zsh/zshrc:d" ~/.zshrc
echo "source $DOTDIR/zsh/zshrc" >> ~/.zshrc
source ~/.zshrc

# source vimrc.vim
touch ~/.vimrc
sed -i "\:$DOTDIR/vim/vimrc.vim:d" ~/.vimrc
echo "source $DOTDIR/vim/vimrc.vim" >> ~/.vimrc

# source tmux.conf
touch ~/.tmux.conf
sed -i "\:$DOTDIR/tmux/tmux.conf:d" ~/.tmux.conf
echo "source-file $DOTDIR/tmux/tmux.conf" >> ~/.tmux.conf
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning tpm..."
  git clone -q --depth 1 $DOT_GITHUB_MIRROR/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# source lazygit.yml
if [ ! -d "$HOME/.config/lazygit" ]; then
  mkdir $HOME/.config/lazygit
fi
cp -f $DOTDIR/lazygit/config.yml ~/.config/lazygit/config.yml
