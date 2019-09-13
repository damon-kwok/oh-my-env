#!/usr/bin/env sh

function gen_app_icon()
{
    appname=$1
    exename=$2
    cfgname=$HOME/$1.desktop
    echo "[Desktop Entry]" > $cfgname
    echo "Type=Application" >> $cfgname
    echo "Name=$exename" >> $cfgname
    echo "GenericName=$appname" >> $cfgname
    echo "Comment=$appname" >> $cfgname
    echo "Exec=sh /home/damon/Applications/$appname/bin/$exename.sh" >> $cfgname
    echo "Icon=/home/damon/Applications/$appname/bin/$exename.png" >> $cfgname
    echo "Terminal=$exename" >> $cfgname
    echo "Categories=$exename;" >> $cfgname
    echo "Name[en_US]=$exename" >> $cfgname

    sudo mv -f $cfgname /usr/local/share/applications/
}

function getexe()
{
    appname=$2
    for element in `ls $1`
    do
        dir_or_file=$1"/"$element
        if [ ! -d $dir_or_file ];then
	        filename=${dir_or_file%.*}
	        extname=${dir_or_file##*.}

	        if [ "$extname" = "png" ];then
                exename="${filename}.sh"
                if [ -f $exename ]; then
                    echo "dir:$dir_or_file"
                    echo "appname:$appname"
		            echo "filename:`basename $filename`"
		            echo "extname:$extname"
                    gen_app_icon $appname `basename $filename`
                fi

	        fi
        fi  
    done
}

function getapp(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]; then
	        if [ -d $dir_or_file/bin ]; then
		        getexe $dir_or_file/bin `basename $dir_or_file`
	        fi
        fi  
    done
}

root_dir="/home/damon/Applications"
getapp $root_dir
