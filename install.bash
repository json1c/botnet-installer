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

if [ -d "telegram-raid-botnet" ]; then
    warning "[*] Botnet dir detected..."
    time_sleep
    mkdir ~/old-botnet
    mv ~/telegram-raid-botnet ~/old-botnet 
    warning "[*] Previous botnet has moved to ~/old-botnet"
else
    succes "[*] Botnet not installed into your system..." 
fi


#shit banner
cat << "EOF" 
╭╮╱╭┳╮╱╭┳━━┳━━━╮
┃┃╱┃┃┃╱┃┣┫┣┫╭━╮┃ telegram: @huis_bn
┃╰━╯┃┃╱┃┃┃┃┃╰━━╮ telegram: @bruhnet
┃╭━╮┃┃╱┃┃┃┃╰━━╮┃
┃┃╱┃┃╰━╯┣┫┣┫╰━╯┃
╰╯╱╰┻━━━┻━━┻━━━╯ 
[*] Botnet now installing into your system...
[*] Wait 5-7 minutes...
EOF

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
            pkg update -y && pkg upgrade -y && pkg install -y git python &>/dev/null
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
    echo "[*] Clonning botnet from git..."
    git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null
    succes "[*] Botnet clonned into your system!"
    echo "[*] Entering to botnet directory..."
    cd ~/telegram-raid-botnet
    succes "[*] All ok"
    echo "[*] Installing packcages..."
    sudo apt update  &>/dev/null && sudo apt install -y ffmpeg git software-properties-common curl &>/dev/null && sudo add-apt-repository ppa:deadsnakes/ppa -y && sudo apt install -y python3.10 python3.10-distutils && curl https://bootstrap.pypa.io/get-pip.py | python3.10 && curl -sL https://deb.nodesource.com/setup_17.x | sudo bash - && sudo apt-get install -y nodejs &>/dev/null
    succes "[*] All packages has been installed!"
    echo "[*] Installing pip packages..."
    python3.10 -m pip install -r requirements.txt  &>/dev/null && python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null
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