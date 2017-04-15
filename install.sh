#!/usr/bin/env bash

# Make directories (if neccessary)
mkdir -p ~/.vim
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/syntax
mkdir -p ~/.vim/snippets

mkdir -p ~/.tmux
mkdir -p ~/.tmux/plugins

# Symlink files
ln -sfv ~/dotfiles/vimrc ~/.vimrc
ln -sfv ~/dotfiles/haskell/haskell.snippet ~/.vim/snippets/haskell.snippet
ln -sfv ~/dotfiles/haskell/syntax/haskell.vim ~/.vim/syntax/haskell.vim
ln -sfv ~/dotfiles/haskell/syntax/cabal.vim ~/.vim/syntax/cabal.vim
ln -sfv ~/dotfiles/haskell/syntax/cabal.vim ~/.vim/syntax/cabal.vim

ln -sfv ~/dotfiles/tmux.conf ~/.tmux.conf

ln -sfv ~/dotfiles/git/gitignore ~/.gitignore
ln -sfv ~/dotfiles/git/gitconfig ~/.gitconfig

# Install Vundle (Vim plugin manager)
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins
# vim silent +PluginInstall +qall
echo "Installing Vundle plugins (this may take a while)..."
echo | echo | vim +PluginInstall +qall &>/dev/null
echo "Done!"

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Compile the vimproc.vim plugin
pushd ~/.vim/bundle/vimproc.vim
make
popd
