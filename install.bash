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

succes() {
  printf '\e[32m'; echo "$@"; printf '\E[0m'
}

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

time_sleep() {
  sleep 5
}

if command -v termux-setup-storage; then
    echo "[*] Termux detected..." && echo "[*] Root not required..."
elif [ "$EUID" -ne 0 ] || [[ "$OSTYPE" == "linux-gnu"* ]]; then 
    echo "[*] Linux detected..."
    error "[!] Run script from root user!"
    exit 1;
else 
    error "[*] An unexpected error has occurred"
    warning "[*] Try to install botnet from instruction"
    exit 1;
fi

if [ "$dir_detected" = "yes" ]; then
	cd ..
fi

if [ -d ~/"telegram-raid-botnet" ]; then
    cd ~/telegram-raid-botnet || {
        warning "[*] Botnet dir detected..."
        time_sleep
        mkdir ~/old-botnet
        mv ~/telegram-raid-botnet ~/old-botnet 
        warning "[*] Previous botnet was moved to ~/old-botnet"
    }
    dir_detected="yes"
else
    succes "[*] Botnet dir not detected"
    fi

#shit banner
cat << "EOF" 
╭╮╱╭┳╮╱╭┳━━┳━━━╮
┃┃╱┃┃┃╱┃┣┫┣┫╭━╮┃ telegram: @huis_bn
┃╰━╯┃┃╱┃┃┃┃┃╰━━╮ telegram: @bruhnet
┃╭━╮┃┃╱┃┃┃┃╰━━╮┃
┃┃╱┃┃╰━╯┣┫┣┫╰━╯┃
╰╯╱╰┻━━━┻━━┻━━━╯ 
EOF
warning "[*] Botnet now installing into your system..."
warning "[*] Wait 5-7 minutes..."

##################################################################

#andoid detect 
if [[ $(uname -o) = 'Android' ]]; then
    if echo "$PREFIX" | grep -o "com.termux"; then
        errorCode=$?
            echo "[*] Clonning botnet from git..."
            git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
            succes "[*] Botnet clonned into your system!"
            echo "[*] Entering to botnet directory..."
            cd ~/telegram-raid-botnet
            succes "[*] All ok"
            echo "[*] Installing packcages..."
            pkg update -y &>/dev/null && pkg upgrade -y &>/dev/null && pkg install -y git python &>/dev/null
            succes "[*] All packages has been installed!"
            echo "[*] Installing pip packages..."
            pip3 install -r requirements.txt  &>/dev/null
            succes "[*] All pip packages has been installed!"

            succes "[*] Starting botnet..." && python3 main.py
elif [[ "$OSTYPE" =~ ^WSL2 ]]; then
errorCode=$?
    warning "[*] You are running script from WSL2, some botnet functions dont work on this platform"
    echo "[*] Clonning botnet from git..."
    git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
    succes "[*] Botnet clonned into your system!"
    echo "[*] Entering to botnet directory..."
    cd ~/telegram-raid-botnet
    succes "[*] All ok"
    echo "[*] Installing packcages..."
    sudo apt install -y python ffmpeg youtube-dl git &>/dev/null
    succes "[*] All packages has been installed!"
    echo "[*] Installing pip packages..."
    pip3 install -r requirements.txt  &>/dev/null
    succes "[*] All pip packages has been installed!"

    succes "[*] Starting botnet..." && python3 main.py
elif echo "$OSTYPE" | grep -qE '^linux-gnu.*' && [ -f '/etc/arch-release' ]; then
errorCode=$?
    echo "[*] Clonning botnet from git..."
    git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
    succes "[*] Botnet clonned into your system!"
    echo "[*] Entering to botnet directory..."
    cd ~/telegram-raid-botnet
    succes "[*] All ok"
    echo "[*] Installing packcages..."
    sudo pacman -S ffmpeg git python-pip youtube-dl python -y &>/dev/null
    succes "[*] All packages has been installed!"
    echo "[*] Installing pip packages..."
    pip3 install -r requirements.txt  &>/dev/null && pip3 install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null
    succes "[*] All pip packages has been installed!"

    succes "[*] Starting botnet..." && python3 main.py  
elif echo "$OSTYPE" | grep -qE '^linux-gnu.*' && [ -f '/etc/debian_version' ]; then
errorCode=$?
    warning '[Warning]: Botnet on Debian based distros requires python 3.10 !'
    read -r '[?] Install python 3.10? (y/n): ' pythoninstall
        if [ "${pythoninstall}" == 'y' ]; then
        echo "[*] Installing important packages..."
        sudo apt install software-properties-common curl -y &>/dev/null 
        succes "[*] Installed!"
        echo "[*] Installing repo for python 3.10..."
        sudo add-apt-repository ppa:deadsnakes/ppa -y &>/dev/null
        succes "[*] Installed!"
        echo "[*] Installing python 3.10"
        sudo apt install -y python3.10 python3.10-distutils &>/dev/null && curl https://bootstrap.pypa.io/get-pip.py | python3.10 &>/dev/null 
        echo "[*] Installed!"
            else
                clear
                warning '[*] User Aborted python 3.10 Installation.'
                exit 1;
        fi
        echo "[*] Clonning botnet from git..."
        git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
        succes "[*] Botnet clonned into your system!"
        echo "[*] Entering to botnet directory..."
        cd ~/telegram-raid-botnet
        succes "[*] All ok"
        echo "[*] Installing packcages..."
        sudo apt update  &>/dev/null && sudo apt install -y ffmpeg git &>/dev/null && curl -sL https://deb.nodesource.com/setup_17.x | sudo bash - && sudo apt-get install -y nodejs &>/dev/null
        succes "[*] All packages has been installed!"
        echo "[*] Installing pip packages..."
        python3.10 -m pip install -r requirements.txt &>/dev/null && python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null
        succes "[*] All pip packages has been installed!"

        succes "[*] Starting botnet..." && python3.10 main.py
else 
    error "[!] An error accurated"
    error "[*] Try to install botnet from instruction."
    clear 
    sleep_time
    succes "[*] Exiting from installer..."
    exit 1;
    fi
fi
if [ $errorCode -ne 0 ]; then
  error "[!] An error accurated"
  error "[*] Try to install botnet from instruction."
  clear 
  sleep_time
  succes "[*] Exiting from installer..."
  exit $errorCode
fi