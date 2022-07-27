#!/bin/bash

# https://github.com/json1c
# Copyright (C) 2022  json1c

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of the License

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
set -e

#some text bruh
warning() {
  printf '\e[36m'; echo "$@"; printf '\E[0m'
}

success() {
  printf '\e[32m'; echo "$@"; printf '\E[0m'
}

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

last_commit() {
if [ -d .git ]; then
  COMMIT=$(git show-branch --no-name HEAD)
  success "[*] Last commit is: $COMMIT";
else
  warning "[*] .git dir not detected"
fi
}

os_print() {
    if command -v termux-setup-storage &>/dev/null; then
        warning "[*] Your system is: Termux"
        termux_install
    else
        DISTRO=$(cat /etc/*-release | grep -w NAME | cut -d= -f2 | tr -d '"')
        warning "[*] Your system is: $DISTRO"
    fi
}

script_exit_msg() {
    error "[!] An error accurated"
    error "[*] Try to install botnet from instruction | https://teletype.in/@lkqas/telegram-raid-botnet"
    clear 
    time_sleep
    success "[*] Exiting from installer..."
}

time_sleep() {
  sleep 5
}

if command -v termux-setup-storage &>/dev/null; then
    success "[*] Termux detected..." && success "[*] Root not required..."
elif [ "$EUID" -ne 0 ] && [[ "$OSTYPE" == "linux-gnu"* ]]; then 
    echo "[*] Linux detected..."
    error "[!] Run script from root user!"
    exit 1;
fi

if [ "$dir_detected" = "yes" ]; then
	cd ..
fi

dir_not_found() {
    warning '[Warning]: Script not detected botnet into your system !'
    echo '[?] Install botnet to your home dir? (y/n) : '
    old_stty_cfg=$(stty -g)
    stty raw -echo
    answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
    stty "$old_stty_cfg"
        if echo "$answer" | grep -iq "^y" ;then
            echo "[*] Installing botnet..."
            git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null 
            success "[*] Installed!"
            success "[*] Please, restart script"
            exit 1;
        else 
            error "[*] User aborted installation"
            exit 1;
fi
}

if [ -d "$HOME/telegram-raid-botnet" ]; then
    {
        cd "$HOME/telegram-raid-botnet"
        warning "[*] Botnet dir detected..."
        time_sleep
        mkdir "$HOME/old-botnet"
        mv "$HOME/telegram-raid-botnet" "$HOME/old-botnet" || error "[*] Dir ~/old-botnet is exist!"
        warning "[*] Previous botnet was moved to ~/old-botnet"
    }
    dir_detected="yes"
else
    success "[*] Botnet dir not detected"
    fi

dir_detection() {
if [ -d "$HOME/telegram-raid-botnet" ]; then
    dir_detected="yes"
    {   
        cd "$HOME/telegram-raid-botnet"
        warning "[*] Botnet dir detected..."
        git pull &>/dev/null || error "[~] An error accurated when user tryed to update botnet"; choice_msg;
        warning "[*] Succefully updated!"
    }
        else
            success "[*] Botnet dir not detected"  
            dir_not_found
    fi
}

termux_install() {
    if [[ $(uname -o) = 'Android' ]]; then
        if echo "$PREFIX" | grep -o "com.termux" &>/dev/null; then
            echo "[*] Installing packcages..."
            pkg update -y &>/dev/null && pkg upgrade -y &>/dev/null && pkg install -y git python &>/dev/null 
            success "[*] All packages has been installed!"
            echo "[*] Clonning botnet from git..."
            git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null 
            success "[*] Botnet clonned into your system!"
            echo "[*] Entering to botnet directory..."
            cd ~/telegram-raid-botnet
            success "[*] All ok"
            echo "[*] Installing pip packages..."
            pip3 install -r requirements.txt  &>/dev/null
            success "[*] All pip packages has been installed!"

            success "[*] Starting botnet..." && python3 main.py
        fi
    fi
}

ubuntu_python() {
warning '[Warning]: Botnet on Debian based distros requires python 3.10 !'
echo '[?] Install python 3.10? (y/n) : '
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty "$old_stty_cfg"
if echo "$answer" | grep -iq "^y" ;then
    echo "[*] Installing important packages..."
    sudo apt install software-properties-common curl git -y &>/dev/null 
    success "[*] Installed!"
    echo "[*] Installing repo for python 3.10..."
    sudo add-apt-repository ppa:deadsnakes/ppa -y &>/dev/null
    success "[*] Installed!"
    echo "[*] Installing python 3.10"
    sudo apt install -y python3.10 python3.10-distutils &>/dev/null && curl -s https://bootstrap.pypa.io/get-pip.py | python3.10 &>/dev/null
    echo "[*] Installed!"
else
    clear
    warning '[*] User Aborted python 3.10 Installation.'
    exit 1;
fi
}

function choice_msg() {
PS3='[ BotnetInstaller ] Please enter your choice : '
options=("Install BoTneT" "Update BoTneT" "exit")
select opt in "${options[@]}"
do
    case $opt in
        "Install BoTneT") break ;;
        "Update BoTneT") dir_detection ;;
        "exit") exit 1 ;;
        *) error "[*] Enter valid option" ;;
    esac
done
}

#shit banner
last_commit
cat << "EOF" 
 _   _ _   _ ___ ____        ____  _   _
| | | | | | |_ _/ ___|      | __ )| \ | | telegram @huis_bn
| |_| | | | || |\___ \ _____|  _ \|  \| | telegram @bruhnet
|  _  | |_| || | ___) |_____| |_) | |\  | 
|_| |_|\___/|___|____/      |____/|_| \_|
EOF
choice_msg
os_print
warning "[*] Botnet now installing into your system..." 
warning "[*] Wait 5-7 minutes..." 
time_sleep


###################   DEBIAN BASE DISTROS  ###############################################

if [ -f '/etc/debian_version' ]; then
        ubuntu_python
        echo "[*] Clonning botnet from git..."
        git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
        success "[*] Botnet clonned into your system!"
        echo "[*] Entering to botnet directory..."
        cd ~/telegram-raid-botnet &>/dev/null
        success "[*] All ok"
        echo "[*] Installing packcages..."
        sudo apt update  &>/dev/null && sudo apt install -y ffmpeg git &>/dev/null && curl -sL https://deb.nodesource.com/setup_17.x | sudo bash - &>/dev/null && sudo apt-get install -y nodejs &>/dev/null
        success "[*] All packages has been installed!"
        echo "[*] Installing pip packages..."
        python3.10 -m pip install -r requirements.txt &>/dev/null && python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null
        success "[*] All pip packages has been installed!"

        success "[*] Starting botnet..." && python3.10 main.py
else 
    script_exit_msg
    exit 1;
fi

######################   WSL2   #####################################################

if [[ "$OSTYPE" =~ ^WSL2 ]]; then
    warning "[*] You are running script from WSL2, some botnet functions dont work on this platform"
    echo "[*] Clonning botnet from git..."
    git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
    success "[*] Botnet clonned into your system!"
    echo "[*] Entering to botnet directory..."
    cd ~/telegram-raid-botnet
    success "[*] All ok"
    echo "[*] Installing packcages..."
    sudo apt install -y python ffmpeg youtube-dl git &>/dev/null
    success "[*] All packages has been installed!"
    echo "[*] Installing pip packages..."
    pip3 install -r requirements.txt  &>/dev/null
    success "[*] All pip packages has been installed!"

    success "[*] Starting botnet..." && python3 main.py
else 
    script_exit_msg
    exit 1;
fi

#########################  ARCH LINUX BASED DISTROS  ##################################################

if [ -f '/etc/arch-release' ]; then
    ubuntu_python
    echo "[*] Clonning botnet from git..."
    git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
    success "[*] Botnet clonned into your system!"
    echo "[*] Entering to botnet directory..."
    cd ~/telegram-raid-botnet
    success "[*] All ok"
    echo "[*] Installing packcages..."
    sudo pacman -S ffmpeg git python-pip youtube-dl python -y &>/dev/null
    success "[*] All packages has been installed!"
    echo "[*] Installing pip packages..."
    pip3 install -r requirements.txt  &>/dev/null && pip3 install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null
    success "[*] All pip packages has been installed!"

    success "[*] Starting botnet..." && python3 main.py  
else 
    script_exit_msg
    exit 1;
fi