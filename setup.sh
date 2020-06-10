# Check if bash exists
if [ -x "$(cat /etc/shells | grep bash | tr -d '\n')" ]; then
    # Create .bash_profile symlink
    # .bash_profile loads bash_rc config
    ln -s -f $HOME/dotfiles/.bash_profile $HOME/.bash_profile
    echo "bash OK"
else
    echo "bash SKIP"
fi

# Create vimrc symlink
if [ -x "$(command -v vim)" ]; then
    ln -s -f $HOME/dotfiles/.vimrc $HOME/.vimrc
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
