# Create vimrc symlink
ln -s -f $HOME/dotfiles/.vimrc $HOME/.vimrc
echo "vim OK\n"

# tmux
if [ -x "$(command -v tmux)" ]; then
    tmux source-file $HOME/dotfiles/.tmux.conf
    echo "tmux OK\n";
else
    echo "tmux SKIP\n";
fi
