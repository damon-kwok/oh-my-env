#!/usr/bin/env sh

title() {
    # echo -e $(tput setaf 14)"\n================================================================================"\
    echo -e $(tput setaf 6)"\n<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"\
	     $(tput sgr0)
    echo -e $(tput setaf 6)"<>\t\t\t\t"$(tput sgr0)"$1"
    echo -e $(tput setaf 6)"<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"\
         $(tput sgr0)
}

tip() {
    # echo -e $(tput setaf 10)"\n------------------------------------------------------------"$(tput sgr0)
    # echo -e $(tput setaf 10)"| $1"$(tput sgr0)
    echo -e "$(tput setaf 6)\n<><><> "$(tput sgr0)"$1"$(tput setaf 6)" >"$(tput sgr0)
    # cowsay "$(tput setaf 6)$1$(tput sgr0)"
}

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
            echo '. $HOME/.oh-my-env/env' >> $dotfile
            . $dotfile
        fi
    fi
}

if [ "$1" == "" ] || [ "$1" == "install" ]; then
	title "OME INSTALL"
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
    # if [ "$OME_OS" = "$OS_CYGWIN" ] || [ "$OME_OS" = "$OS_MSYS2" ]; then
        # echo_error "'install' does not support windows"
        # return
    # fi
    $HOME/.oh-my-env/bin/ome init
fi

# if [ "$1" == "uninstall" ]; then
#     rm -rf $HOME/.oh-my-env/
#     rm -rf $HOME/.ome_local/
# fi
