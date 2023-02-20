#! /usr/bin/env bash
DOTDIR=~/.dotfiles

# wsl 启动配置
if [[ $(uname -r) =~ WSL2 ]]; then
  if [ ! -d /etc/wsl ];then
    sudo mkdir /etc/wsl
  fi
  sudo cp -r $DOTDIR/wsl/wsl.conf /etc
  sudo cp -r $DOTDIR/wsl/init.sh /etc/wsl
  sudo cp -r $DOTDIR/wsl/WSLInterop.conf /usr/lib/binfmt.d
fi
