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
