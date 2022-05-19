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

if [ "$EUID" -ne 0 ]
  then 
    clear
    error "Please run script as root"
  exit 1;
fi

if [[ -d "telegram-raid-botnet" ]]
then
    error "Botnet already installed on your system."
    exit 1;
fi

printf "╭╮╱╭┳╮╱╭┳━━┳━━━╮"
printf "┃┃╱┃┃┃╱┃┣┫┣┫╭━╮┃"
printf "┃╰━╯┃┃╱┃┃┃┃┃╰━━╮"
printf "┃╭━╮┃┃╱┃┃┃┃╰━━╮┃"
printf "┃┃╱┃┃╰━╯┣┫┣┫╰━╯┃"
printf "╰╯╱╰┻━━━┻━━┻━━━╯"
printf "Join in our Telegram channels"
printf "@HUIS_BN & @BRUHNET "
printf "Botnet now installing into your system..."
printf "Wait 5-7 minutes..."

##################################################################

if  [[ $(uname -o) = 'Android' ]]; then
    if echo $PREFIX | grep -o "com.termux"; then
        if [[ $EUID -eq 0 ]]; then
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
if cat /etc/*release | grep ^NAME | grep CentOS || cat /etc/*release | grep ^NAME | grep Red || cat /etc/*release | grep ^NAME | grep Fedora; then 
    echo -n "Installing Packcages...";  yum install python39 && yum install python39-pip && yum install git &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; pip3.9 install -U $req &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";

    sleep 5
    cd ~/telegram-raid-botnet
    python3.9 main.py
fi
if [[ "$OSTYPE" =~ ^WSL2 ]]; then
    echo " Warning you are using WSL botnet may work with errors "
    echo -n "Installing Packcages...";  apt install -y python ffmpeg youtube-dl git &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; pip3 install -U $req &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";
    sleep 5

    cd ~/telegram-raid-botnet
    python3 main.py
fi
if cat /etc/*release | grep ^NAME | grep "Arch Linux" || cat /etc/*release | grep ^NAME | grep "Artix Linux" || cat /etc/*release | grep ^NAME | grep Antix || cat /etc/*release | grep ^NAME | grep Manjaro || cat /etc/*release | grep ^NAME | grep Parabola; then
    echo -n "Installing Packcages...";  sudo pacman -S ffmpeg git python-pip youtube-dl python &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; pip install -U $req && pip3 install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";
    sleep 5

    cd ~/telegram-raid-botnet
    python main.py    
fi
if  cat /etc/*release | grep ^NAME | grep Ubuntu || cat /etc/*release | grep ^NAME | grep Debian || cat /etc/*release | grep ^NAME | grep Mint || cat /etc/*release | grep ^NAME | grep Mint; then
    echo -n "Installing Packcages...";  apt update -y && apt install -y ffmpeg git software-properties-common curl && add-apt-repository ppa:deadsnakes/ppa -y && apt install -y python3.10 python3.10-distutils && curl https://bootstrap.pypa.io/get-pip.py | python3.10 && curl -sL https://deb.nodesource.com/setup_17.x | sudo bash - && sudo apt-get install -y nodejs &>/dev/null; echo " All packages has been installed!"; 
    echo -n "Installing Pip packages..."; python3.10 -m pip install -U $req && python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U &>/dev/null; echo "Pip packages had been installed!"; 
    echo -n "Starting installing botnet..." git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet &>/dev/null; echo "Botnet successfully installed!";        
    sleep 5 

    cd telegram-raid-botnet
    python3.10 main.py
    fi  
else 
    error "Something went wrong."
    error "Try to install botnet from instruction."
    exit 1;
fi
    else
        clear
        error "Your os not supported!"
        error "Try to install botnet from instruction"
        exit 1;
fi
