#!/usr/bin/env bash

PREFIX=~/src/dotfiles
MY_BIN=~/bin

link_file () {
    echo "Checking $2 to $1"
    if [ ! -L "$2" ]; then
        if [ -e "$2" ]; then
            echo "$2 already exists - do nothing"
        else
            echo "linking $2 to $1"
            ln -s "$1" "$2"
        fi
    fi
}

create_dir () {
    local dirname="$1"
    if [ ! -d "$dirname" ]; then
        echo "Creating dir $dirname"
        mkdir "$dirname"
    fi
}

is_darwin () {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi
    return 1
}

# my bin files
create_dir "${MY_BIN}"
link_file ${PREFIX}/bin/openinemacs.sh ${MY_BIN}/openinemacs.sh
link_file ${PREFIX}/bin/ssh-agent-autostart.sh ${MY_BIN}/ssh-agent-autostart.sh
link_file ${PREFIX}/bin/update_all.sh ${MY_BIN}/update_all.sh
link_file ${PREFIX}/bin/wcgrep ${MY_BIN}/wcgrep

# ssh files
create_dir ~/.ssh
chmod 700 ~/.ssh
if is_darwin; then
    link_file ${PREFIX}/home/.ssh/config_mac ~/.ssh/config
else
    link_file ${PREFIX}/home/.ssh/config ~/.ssh/config
    link_file ${PREFIX}/home/.ssh/rc ~/.ssh/rc
fi

# zsh
link_file ${PREFIX}/home/.bash_aliases.sh ~/.bash_aliases.sh
link_file ${PREFIX}/home/.bash_ross ~/.bash_ross
link_file ${PREFIX}/home/.bashrc ~/.bashrc
link_file ${PREFIX}/work/.bash_aws ~/.bash_aws
link_file ${PREFIX}/home/.p10k.zsh ~/.p10k.zsh
link_file ${PREFIX}/home/.zprofile ~/.zprofile
link_file ${PREFIX}/home/.zshrc ~/.zshrc

# editors
link_file ${PREFIX}/home/.vimrc ~/.vimrc
link_file ${PREFIX}/home/.emacs.d ~/.emacs.d

# tmux
link_file ${PREFIX}/home/.tmux.conf ~/.tmux.conf
[ ! is_darwin ] && link_file ${PREFIX}/home/.tmux.agent.conf ~/.tmux.agent.conf

# asdf
link_file ${PREFIX}/home/.asdfrc ~/.asdfrc

# git
link_file ${PREFIX}/work/.gitconfig ~/.gitconfig

# upwind specifics
link_file ${PREFIX}/work/.bash_upwind ~/.bash_upwind

# sudoers
#echo "Updating sudoers.d"
#NEXPOSE_SUDOERS=/etc/sudoers.d/nexpose
#if is_darwin; then
#    sudo sh -c "cp ${PREFIX}/work/nexpose_mac ${NEXPOSE_SUDOERS}; chown root:wheel ${NEXPOSE_SUDOERS}; chmod 440 ${NEXPOSE_SUDOERS}"
#else
#    sudo sh -c "cp ${PREFIX}/work/nexpose_linux ${NEXPOSE_SUDOERS}; chown root:root ${NEXPOSE_SUDOERS}; chmod 440 ${NEXPOSE_SUDOERS}"
#fi

# ghostty
GHOSTTY_DIR="${HOME}/Library/Application Support/com.mitchellh.ghostty"
create_dir "${GHOSTTY_DIR}"
link_file ${PREFIX}/home/ghostty/config "${GHOSTTY_DIR}/config"

# neovim
KICKSTART_DIR=~/src/kickstart.nvim
if [ ! -d "$KICKSTART_DIR" ]; then
    gh repo clone forpster/kickstart.nvim ~/src/kickstart.nvim
fi
link_file ~/src/kickstart.nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
