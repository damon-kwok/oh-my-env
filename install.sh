#!/usr/bin/env sh

find_str() {
    local str=$1
    local file=$2
    
    grep $str $file >/dev/null
    
    if [ $? -eq 0 ]; then
	    # echo "found:$str"
	    return $(( 1 ));
    else
	    # echo "not found:$str"
	    return $(( 0 ));
    fi
}

ome_write_env_to_dotfile() {
    local dotfile=$1
    if [ -f $dotfile ]; then
        find_str "oh-my-env" $dotfile
        if [ $? -eq 0 ]; then
            echo "" >> $dotfile
            echo "# oh-my-env" >> $dotfile
            echo ". \$HOME/.oh-my-env/env" >> $dotfile
            . $dotfile
        fi
    fi
}

if [ "`uname`" = "Darwin" ]; then
	echo "Install Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    
	echo "Install wget & coreutils"        
    brew install wget
    brew install coreutils
    
	echo "Install font-bitstream-vera"        
    brew tap homebrew/cask-fonts
    brew cask install font-bitstream-vera

	echo "Install Emacs"
    brew tap railwaycat/emacsmacport
    brew cask install emacs-mac		
fi

if [ "$1" == "install" ]; then
	echo "========OME INSTALL========"
	if [ ! -f "$HOME/.oh-my-env/.git/index" ]; then
	    git clone https://github.com/damon-kwok/oh-my-env $HOME/.oh-my-env --depth=1
	else
	    cd $HOME/.oh-my-env
	    git pull
	fi

	ome_write_env_to_dotfile $HOME/.profile 
	ome_write_env_to_dotfile $HOME/.shrc
	ome_write_env_to_dotfile $HOME/.bashrc
	ome_write_env_to_dotfile $HOME/.zshrc

	. $HOME/.oh-my-env/env
fi

if [ "$1" == "uninstall" ]; then
    rm -rf $HOME/.oh-my-env/
    rm -rf $HOME/.ome_local/
fi
