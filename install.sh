#!/usr/bin/env sh

title() {
    echo -e $(tput setaf 6)"\n<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"$(tput sgr0)
    echo -e $(tput setaf 6)"<>\t\t\t\t"$(tput sgr0)"$1"
    echo -e $(tput setaf 6)"<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"\
         $(tput sgr0)
}
tip() {
    echo -e "$(tput setaf 6)\n<><><> "$(tput sgr0)"$1"$(tput setaf 6)" >"$(tput sgr0)
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

host_upgrade() {
    local ip=$1
    local name=$2
    
    if [ "$OME_OS" = "$OS_MSYS2" ]; then
        local hostfile=/c/Windows/System32/drivers/etc/hosts
    elif [ "$OME_OS" = "$OS_CYGWIN" ]; then
        local hostfile=/cygdrive/c/Windows/System32/drivers/etc/hosts
    else
        local hostfile=/etc/hosts
    fi
    
    find_str $name $hostfile
    if [ $? -eq 0 ]; then
		echo "Add '$ip $name' to $hostfile"
		if [ "$OME_OS" = "$OS_CYGWIN" ] || [ "$OME_OS" = "$OS_MSYS2" ]; then
			echo '$ip $name' >> /etc/hosts
		else
			sudo sh -c "echo '$ip $name' >> /etc/hosts"
		fi
    #else
	#    echo "'$ip $name' is exist in $hostfile"
    fi
}

get_os_type() {
    if [ $OS_UNKNOW == $OME_OS ]; then
        # $OS_UNKNOW) os_choose;;    
        tip "please choose your os:"
        echo "    1) macOS"
        echo "    -------------------------"
        echo "    2) Cygwin"
        echo "    3) Msys2"
        echo "    -------------------------"
        echo "    4) ArchLinux"
        echo "    5) Debian"
        echo "    6) Ubuntu/LinuxMint/ElementaryOS"
        echo "    7) Redhat/CentOS(yum)"
        echo "    8) Fedora22+(dnf)"
        echo "    -------------------------"
        echo "    9) FreeBSD"
        echo "    -------------------------"
        echo "    q) quit"

        read -p "please enter your choice:" item
        case "$item" in
            "1") export OME_OS=$OS_MACOS;;
            "2") export OME_OS=$OS_CYGWIN;;
            "3") export OME_OS=$OS_MSYS2;;
            "4") export OME_OS=$OS_ARCH;;
            "5") export OME_OS=$OS_DEBIAN;;
            "6") export OME_OS=$OS_UBUNTU;;
            "7") export OME_OS=$OS_REDHAT;;
            "8") export OME_OS=$OS_FEDORA;;
            "9") export OME_OS=$OS_FREEBSD;;
        esac
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

###############################################################################
title "env loading"
# OSlist: https://git-scm.com/download/linux
# Linux
export OS_DEBIAN="Debian"
export OS_UBUNTU="Ubuntu"
export OS_REDHAT="RedHat" # Red Hat Enterprise Linux, Oracle Linux, CentOS, Scientific Linux, et al.
export OS_FEDORA="Fedora"
export OS_ARCH="ArchLinux"
export OS_GENTOO="Gentoo"
export OS_SUSE="openSUSE"
export OS_SLACKWARE="Slackware"
export OS_NIXOS="NixOS"
export OS_ALPINE="Alpine" # musl libc| busybox https://www.linuxprobe.com/alpine-linux-released.html
export OS_VOID="VoidLinux"
export OS_MAGEIA="Mageia" # Mandriva Linux
export OS_SLITAZ="Slitaz" # busybox
export OS_GUIXSD="GuixSD"
# Unix
export OS_MACOS="macOS"
export OS_AIX="AIX"
export OS_SOLARIS="Solaris" #OpenCSW illumos(kernel):OpenIndiana SmartOS DogeOS
export OS_FREEBSD="FreeBSD"
export OS_OPENBSD="OpenBSD"
export OS_NETBSD="NetBSD"
export OS_DFBSD="DragonflyBSD"
export OS_TRUEOS="TrueOS"
# Windows
export OS_CYGWIN="Cygwin"
export OS_MSYS2="Msys2"
# Other
export OS_ANDROID="Android"
export OS_UNKNOW="Unknow"

# PKG-list: Yum APT SUSE AUR

# Arch-list:
#https://github.com/llvm-mirror/llvm/blob/a1cdcbb384fcf1a0332b3d8b7a9240e5c3ca5a14/docs/GettingStarted.rst#local-llvm-configuration
# AArch64, AMDGPU, ARM, BPF, CppBackend, Hexagon, Mips, MSP430, NVPTX, PowerPC, Sparc, SystemZ X86, XCore

export OME_ARCH="`uname -m`"
# export OME_SHELL="`ps | grep $$ | awk '{print $4}'`"
export OME_SHELL="`basename $SHELL`"

# case "`uname -o`" in
case "`uname -s`" in
    "GNU/Linux" | "Linux")
        if [ "$(uname -o)" = Android ]; then
            export OME_OS=$OS_ANDROID
        elif [ "`command -v yum`" != "" ]; then
            os=`cat /etc/system-release | head -n 1 | cut -d ' ' -f 1`
            if [ "$os" = "CentOS" ] || [ "$os" = "RedHat" ]; then
                export OME_OS=$OS_REDHAT
            else
                export OME_OS=$OS_FEDORA
            fi
        # elif [ "`command -v yum`" != "" ]; then
        elif [ "`command -v zypper`" != "" ]; then
            export OME_OS=$OS_SUSE
        elif [ "`command -v nix`" != "" ]; then
            export OME_OS=$OS_NIXOS
        elif [ "`command -v guix`" != "" ]; then
            export OME_OS=$OS_GUIXSD
        elif [ "lsb_release" != "" ]; then
            case "`lsb_release -is`" in
                "Debian")
                    export OME_OS=$OS_DEBIAN;;
                "Ubuntu"|"elementary"|"LinuxMint")
                    export OME_OS="$OS_UBUNTU";;
                "ManjaroLinux"|"Arch")
                    export OME_OS=$OS_ARCH;;
                *)
                    export OME_OS="`lsb_release -is`";;
            esac
        else
            export OME_OS=$OS_UNKNOW
        fi
        ;;
    CYGWIN*) export OME_OS=$OS_CYGWIN;;
    MINGW* | MSYS*) export OME_OS=$OS_MSYS2;;
    FreeBSD) export OME_OS=$OS_FREEBSD;;
    DragonFly) export OME_OS=$OS_DFBSD;;
    NetBSD) export OME_OS=$OS_NETBSD;;
    Darwin) export OME_OS=$OS_MACOS;;
    *) export OME_OS=$OS_UNKNOW;;
esac
###############################################################################
title "hosts init"
host_upgrade 192.30.253.113 github.com
host_upgrade 151.101.44.249 github.global.ssl.fastly.net
host_upgrade 103.245.222.133 assets-cdn.github.com
host_upgrade 23.235.47.133 assets-cdn.github.com
host_upgrade 203.208.39.104 assets-cdn.github.com
host_upgrade 204.232.175.78 documentcloud.github.com
host_upgrade 204.232.175.94 gist.github.com
host_upgrade 107.21.116.220 help.github.com
host_upgrade 207.97.227.252 nodeload.github.com
host_upgrade 199.27.76.130 raw.github.com
host_upgrade 107.22.3.110 status.github.com
host_upgrade 204.232.175.78 training.github.com
host_upgrade 207.97.227.243 www.github.com
host_upgrade 185.31.16.184 github.global.ssl.fastly.net
host_upgrade 192.30.253.120 codeload.github.com
host_upgrade 185.199.110.154 github.githubassets.com
host_upgrade 185.199.111.153 customer-stories-feed.github.com
host_upgrade 185.31.18.133 avatars0.githubusercontent.com
host_upgrade 185.31.19.133 avatars1.githubusercontent.com
host_upgrade 151.101.100.133 avatars2.githubusercontent.com
host_upgrade 151.101.100.133 avatars3.githubusercontent.com
host_upgrade 151.101.100.133 avatars4.githubusercontent.com
host_upgrade 151.101.100.133 avatars5.githubusercontent.com
host_upgrade 151.101.100.133 avatars6.githubusercontent.com
host_upgrade 151.101.100.133 avatars7.githubusercontent.com
host_upgrade 151.101.100.133 avatars8.githubusercontent.com

host_upgrade 199.232.4.133 raw.githubusercontent.com
host_upgrade 209.126.119.175 ipaddress.com
host_upgrade 140.82.114.25 live.github.com
host_upgrade 199.232.28.133 camo.githubusercontent.com
# host_upgrade 34.196.247.240 collector.githubapp.com
host_upgrade 52.7.232.208 collector.githubapp.com
###############################################################################
title "deps init"
get_os_type
case $OME_OS in
	# Linux
	# $OS_DEBIAN) ;;
	# $OS_UBUNTU) ;;
	$OS_DEBIAN|$OS_UBUNTU)
		# https://github.com/AndyYoungDev/ubuntu-aliyun-sources"
		tip "use aliyun source:"
		sudo curl -L https://github.com/AndyYoungDev/ubuntu-aliyun-sources/releases/download/shell/change.sh | bash
		
		# if [ ! -f /etc/apt/sources.list.d/ubuntu-elisp-ubuntu-ppa-xenial.list ]; then
		tip "add ppa:emacs"
		sudo add-apt-repository -y ppa:ubuntu-elisp
		# fi

		# if [ ! -f /etc/apt/sources.list.d/graphics-drivers-ubuntu-ppa-xenial.list ]; then
		tip "add ppa:nvidia-driver"
		sudo add-apt-repository -y ppa:graphics-drivers/ppa
		# fi
		
		readp "update system?"
		if [ $? -eq 1 ]; then
			sudo apt update
			sudo apt dist-upgrade -y   
		fi

		tip "install base tool"
		sudo apt install -y git subversion wget curl make \
			 tar zip unzip rlwrap coreutils findutils diffutils \
			 ttf-bitstream-vera

		readp "X mode?"
		if [ $? -eq 1 ]; then
			sudo apt install -y software-properties-gtk emacs-snapshot
			readp "install nvidia-driver?"
			if [ $? -eq 1 ]; then
				sudo apt install -y nvidia-driver-390     
				# nomodeset
				readp "nomodeset for grub.cfg?"
				if [ $? -eq 1 ]; then
					# replace-str "quiet splash" "nomodeset" /boot/grub/grub.cfg 1
					sudo perl -pi -e 's|quiet splash|nomodeset|g' /boot/grub/grub.cfg
				fi
			fi
		else
			sudo apt install -y emacs-snapshot-nox
		fi
		;;
	# $OS_REDHAT) ;;
	# $OS_FEDORA) ;;
	$OS_REDHAT|$OS_FEDORA)
		if [ "$OME_OS" = "$OS_REDHAT" ]; then
			# RHEL 8 or compatible like CentOS
			sudo dnf install -y --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
			sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
			sudo dnf install -y --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm

			readp "centos:y REHL:n"
			if [ $? -eq 1 ]; then
				# CentOS 8 required additional step
				sudo dnf config-manager --enable PowerTools
			else
				# RHEL 8 required additional step
				sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-*-rpms"
			fi
		fi
		
		readp "update system?"
		if [ $? -eq 1 ]; then
			sudo dnf -y update
		fi

		sudo dnf install -y git subversion wget curl make \
			 tar zip unzip rlwrap coreutils findutils diffutils \
			 emacs
		;;
	$OS_ARCH)
		readp "update system?"
		# if [ -n "$1" ]; then
		if [ $? -eq 1 ]; then
			# sudo pacman-mirrors -g
			readp "pacman: use china mirror?"
			if [ $? -eq 1 ]; then
				sudo pacman-mirrors -c China
			fi
			sudo pacman -Syyu
			sudo pacman -S trizen
		fi
		#sudo pacman -S opendesktop-fonts
		#sudo pacman -S firefox

		sudo pacman -S git subversion wget curl make \
			   tar zip unzip rlwrap coreutils findutils diffutils \
			   net-tools ttf-bitstream-vera emacs
		;;
	$OS_GENTOO) ;;
	$OS_SUSE)
		readp "SUSE: use china mirror?"
		if [ $? -eq 1 ]; then
			# disable old source
			sudo zypper mr -da

			# use new source
			# zypper addrepo -f http://mirrors.aliyun.com/opensuse/factory/repo/oss/ openSUSE-Oss
			# zypper addrepo -f http://mirrors.aliyun.com/opensuse/factory/repo/non-oss/ openSUSE-Non-Oss
		fi
		readp "update system?"
		if [ $? -eq 1 ]; then
			sudo zypper refresh
			sudo zypper update
		fi
		sudo zypper install git subversion wget curl make \
			 tar zip unzip rlwrap coreutils findutils diffutils \
			 bitstream-vera-fonts emacs
		;;
	$OS_SLACKWARE) ;;
	# install slapt-get
	# use 163 mirror:http://mirrors.163.com/.help/slackware.html
	$OS_NIXOS) ;;
	$OS_VOID) ;;
	$OS_ALPINE) ;;
	$OS_MAGEIA) ;;
	$OS_SLITAZ) ;;
	# Unix
	$OS_MACOS)
		echo "Install Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		
		# echo "Install wget & coreutils findutils"
		# brew install wget
		# brew install coreutils findutils
		brew install git subversion wget curl make \
			 tar zip unzip rlwrap coreutils findutils diffutils
		
		echo "Install font-bitstream-vera"
		brew tap homebrew/cask-fonts
		brew cask install font-bitstream-vera

		echo "Install Emacs"
		brew tap railwaycat/emacsmacport
		brew cask install emacs-mac
		;;
	$OS_AIX) ;;
	$OS_SOLARIS) ;;
	$OS_FREEBSD)
		readp "update system?"
		if [ $? -eq 1 ]; then
			sudo pkg update
			sudo pkg upgrade
		fi

		sudo pkg install git subversion wget curl gmake \
			 bash zip unzip rlwrap coreutils findutils diffutils \
			 zh-font-std bitstream-vera emacs
		
		# tip "install mate desktop"
		# sudo pkg install xorg slime mate
		# sudo sh -c 'echo "moused_enable=\"YES\"" >> /etc/rc.conf'
		# sudo sh -c 'echo "dbus_enable=\"YES\"" >> /etc/rc.conf'
		# sudo sh -c 'echo "hald_enable=\"YES\"" >> /etc/rc.conf'
		# sudo sh -c 'echo "slim_enable=\"YES\"" >> /etc/rc.conf'
		# sh -c 'echo "exec mate-session" >> ~/.xinit'

		# sudo user:
		# /usr/local/etc/soduers

		# tip "su Sorry"
		# cat /etc/group
		# wheel:*:0:root
		# wheel:*:0:root,damon

		;;
	$OS_OPENBSD) ;;
	$OS_NETBSD) ;;
	$OS_DFBSD) ;;
	# Windows
	$OS_CYGWIN)
		readp "upgrade apt-cyg tools?"
		if [ $? -eq 1 ]; then
			# 1. wget
			# rm -rf /usr/bin/apt-cyg
			# cd /usr/bin/
			# wget https://raw.githubusercontent.com/kou1okada/apt-cyg/master/apt-cyg
			# perl -pi -e 's|http://ftp.jaist.ac.jp/pub/cygwin|http://mirrors.163.com/cygwin|g' /usr/bin/apt-cyg
			# cp -rf /usr/bin/apt-cyg /usr/bin/apt
			# chmod +x /usr/bin/apt-cyg
			# chmod +x /usr/bin/apt

			# 2. git 1:
			# cd $OME_PREFIX
			# git clone https://github.com/kou1okada/apt-cyg.git
			# ln -s "$(realpath apt-cyg/apt-cyg)" /usr/local/bin/
			# cp /usr/local/bin/apt-cyg /usr/local/bin/apt

			# 3. git 2:
			github_upgrade kou1okada/apt-cyg $OME_PREFIX/apt-cyg
			if [ ! -f "/usr/local/bin/apt-cyg" ]; then
				ln -s $OME_PREFIX/apt-cyg/apt-cyg /usr/local/bin/
			fi
		fi
		apt install git subversion wget curl make \
			tar zip unzip rlwrap coreutils findutils diffutils \
			xdg-utils chere emacs-w32
		;;
	$OS_MSYS2)
		#readp "msys2: use china morrir?"
		#if [ $? -eq 1 ]; then
		#	cp -f $OME_ROOT/conf/msys2/* /etc/pacman.d/
		#fi
		#readp "update system?"
		#if [ $? -eq 1 ]; then
		#	pacman -Syyu
		#fi
		# pacman -Sy pacman-mirrors
		
		find_str "tuna.tsinghua.edu.cn" /etc/pacman.d/mirrorlist.mingw32
		if [ $? -eq 0 ]; then
			tip "mirrorlist fix"
			echo "Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686" >> /etc/pacman.d/mirrorlist.mingw32
			echo "Server = Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64" >> /etc/pacman.d/mirrorlist.mingw64
			echo 'Server = Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch' >> /etc/pacman.d/mirrorlist.msys
		else
			tip "mirrorlist is already fix"
		fi
		
		pacman -S git subversion wget curl make \
			   tar zip unzip rlwrap coreutils findutils diffutils \
			   mingw-w64-x86_64-emacs
		;;
	# Other
	$OS_UNKNOW) ;;
esac
###############################################################################
title "git config"
git config --global core.editor $EDITOR
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.safecrlf warn

git config --global user.email "damon-kwok@outlook.com"
git config --global user.name "damon-kwok"
# git config --global credential.helper 'cache --timeout=36000'
git config --global credential.helper store

git config --global color.ui true

git config --global merge.tool emerge
git config --global mergetool.diffmerge.cmd "emerge \$LOCAL \$BASE \$REMOTE \$MERGED"
git config --global mergetool.keepBackup false

git config --global diff.tool ediff
git config --global difftool.ediff.cmd "ediff \"\$LOCAL\" \"\$REMOTE\""
git config --global difftool.prompt false
###############################################################################
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

$HOME/.oh-my-env/bin/ome pull
bash
# fi


