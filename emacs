#!/usr/bin/env sh

link_init_el() {
    bkdir=$HOME/emacs-config-backup/`date +%Y-%m-%d@%H-%M-%S`
    mkdir -p $bkdir

    if [ -e $HOME/.emacs ]; then
        mv $HOME/.emacs $bkdir
    fi
    if [ -e $HOME/.emacs.d/init.el ]; then
        mv $HOME/.emacs.d/init.el $bkdir
    fi

    if [ -e $HOME/emacs-config ]; then
        mv $HOME/emacs-config $bkdir
    fi

    cp -f $HOME/.oh-my-emacs/emacs-config/init.el $HOME/.emacs.d/init.el 

    # tip "link .emacs.d/"
    # if [ ! -d "$HOME/.emacs.d/.git/" ]; then
        # mv $HOME/.emacs.d/ $bkdir
        # echo "your .emacs.d/ backup to '$bkdir'"
    # fi
}

emacs_install() {
    github_upgrade damon-kwok/oh-my-emacs $HOME/.oh-my-emacs
    link_init_el
}

emacs_uninstall() {
    echo_error "'emacs_uninstall' not implemented"
}

emacs_exist_p() {
    echo_error "'emacs_exist_p' not implemented"
}

emacs_info() {
    echo_error ""
}