#!/bin/bash

# https://github.com/json1c
# Copyright (C) 2021  json1c

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of the License

# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
set -e

req="telethon toml rich youtube-dl ffmpeg-python"

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

if [ "$EUID" -ne 0 ] || [[ "$OSTYPE" == "linux-gnu"* ]]; then 
    echo "Linux detected..."
    error "Run script from root user!"
    exit 1;
elif [[ $(uname -o) = 'Android' ]]; then
    echo "Termux detected..." && echo "Root dont required..."
fi

if [[ ! -d ~/telegram-raid-botnet ]]
then
    error "Botnet already installed into your system." 
    exit 1;
fi

#shit banner
cat << "EOF" 
╭╮╱╭┳╮╱╭┳━━┳━━━╮
┃┃╱┃┃┃╱┃┣┫┣┫╭━╮┃
┃╰━╯┃┃╱┃┃┃┃┃╰━━╮
┃╭━╮┃┃╱┃┃┃┃╰━━╮┃
┃┃╱┃┃╰━╯┣┫┣┫╰━╯┃
╰╯╱╰┻━━━┻━━┻━━━╯
Telegram channels:
@HUIS_BN & @BRUHNET 
Botnet now installing into your system...
Wait 5-7 minutes...
EOF

##################################################################

#andoid detect 
if  [[ $(uname -o) = 'Android' ]]; then
    if echo $PREFIX | grep -o "com.termux"; then
            androidreq="telethon toml rich" 
            echo -n "Installing packcages..."; pkg upgrade -y && pkg update -y && pkg install -y git python &>/dev/null; echo " All packages has been installed!";
            echo -n "Installing pip packages..."; pip3 install -U $androidreq  &>/dev/null; echo " All pip packages has been installed!";
            echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";

            cd ~/telegram-raid-botnet
            python3 main.py
        else
            error "You are running script not from termux"
            error "Install Termux from Fdroid and run installer"
            exit 1;
    fi
if [[ "$OSTYPE" =~ ^WSL2 ]]; then
    echo -n "Installing Packcages..."; sudo apt install -y python ffmpeg youtube-dl git &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; pip3 install -U $req &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";
    sleep 5

    cd ~/telegram-raid-botnet
    python3 main.py
fi
if cat /etc/*release | grep ^NAME | grep "Arch Linux" || cat /etc/*release | grep ^NAME | grep "Artix Linux" || cat /etc/*release | grep ^NAME | grep Antix || cat /etc/*release | grep ^NAME | grep Manjaro || cat /etc/*release | grep ^NAME | grep Parabola; then
    echo -n "Installing Packcages...";  sudo pacman -S ffmpeg git python-pip youtube-dl python -y &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; pip install -U $req && pip3 install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";
    sleep 5

    cd ~/telegram-raid-botnet
    python main.py    
fi
if  cat /etc/*release | grep ^NAME | grep Ubuntu || cat /etc/*release | grep ^NAME | grep Debian || cat /etc/*release | grep ^NAME | grep Mint || cat /etc/*release | grep ^NAME | grep Mint; then
    echo -n "Installing Packcages..."; sudo apt update -y && sudo apt install -y ffmpeg git software-properties-common curl && sudo add-apt-repository ppa:deadsnakes/ppa -y && sudo apt install -y python3.10 python3.10-distutils && curl https://bootstrap.pypa.io/get-pip.py | python3.10 && curl -sL https://deb.nodesource.com/setup_17.x | sudo bash - && sudo apt-get install -y nodejs &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; python3.10 -m pip install -U $req && python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";        
    sleep 5 

    cd ~/telegram-raid-botnet
    python3.10 main.py
    fi  
else 
    error "An error accurated"
    error "Try to install botnet from instruction."
    exit 1;
fi