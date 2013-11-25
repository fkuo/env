#!/bin/bash

function copyifdiff {
    diff $1 $2
    if [ $? -ne 0 ]; then
        cp $1 $2
    fi
}

copyifdiff gitconfig ~/.gitconfig
copyifdiff zshrc ~/.zshrc
copyifdiff fred.zsh-theme ~/.oh-my-zsh/themes/fred.zsh-theme
copyifdiff profile ~/.profile
copyifdiff ~/.jshintrc jshintrc
copyifdiff vimrc ~/.vimrc
