# Check if bash exists
if [ -x "$(cat /etc/shells | grep bash | tr -d '\n')" ]; then
    # Create .bash_profile symlink
    # .bash_profile loads bash_rc config
    ln -s -f $HOME/dotfiles/.bash_profile $HOME/.bash_profile
    echo "bash OK"
else
    echo "bash SKIP"
fi

# Create .vimrc and .vim directory symlinks
if [ -x "$(command -v vim)" ]; then
    ln -s -f $HOME/dotfiles/.vimrc $HOME/.vimrc

    # clone airline into .vim directory
    if [ -d $HOME/dotfiles/.vim/pack/dist/start/vim-airline/.git ]; then
        cd $HOME/dotfiles/.vim/pack/dist/start/vim-airline && git pull origin master
    else
        git clone git@github.com:vim-airline/vim-airline.git $HOME/dotfiles/.vim/pack/dist/start/vim-airline
    fi

    ln -s -f -T $HOME/dotfiles/.vim/ $HOME/.vim

    echo "vim OK"
else
    echo "vim SKIP"
fi

# tmux
if [ -x "$(command -v tmux)" ]; then
    tmux source-file $HOME/dotfiles/.tmux.conf
    echo "tmux OK";
else
    echo "tmux SKIP";
fi
