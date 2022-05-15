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


if  [[ $(uname -o) = 'Android' ]]; then
    if echo $PREFIX | grep -o "com.termux"; then
        req="telethon toml rich"
        clear
        echo "Join in our Telegram channels : @huis_bn & @bruhnet"
        echo "Detected System : Android (termux)"
        echo "Package manager : pkg"
        echo "Installing packages for your system..."
        echo ""
        echo "Wait 5-7 minutes..."
        sleep 5
        pkg update && pkg upgrade
        pkg install -y git python 
        pip3 install -U $req
        clear
        echo "All packages installed!"
        sleep 2 
        clear
        echo "Starting botnet installation..."
        sleep 2
        git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet

        echo "Enter commands:"
        echo ""
        echo "cd telegram-raid-botnet"
        echo "python3.10 main.py"
fi
elif cat /etc/*release | grep ^NAME | grep CentOS || cat /etc/*release | grep ^NAME | grep Red || cat /etc/*release | grep ^NAME | grep Fedora; then 
    if [[ $UID = 0 ]]; then
        printf "\033c"
        echo "Join in our Telegram channels : @huis_bn & @bruhnet"
        echo "Detected OS : $(cat /etc/*release | grep ^NAME)"
        echo "Packet Manager : Yum"
        echo "Installings packages for your system..."
        sleep 5
        yum -y install python39 python39-pip git
        pip3.9 install -U $req
        printf "\033c"
        echo "All packages installed!"
        sleep 2
        printf "\033c"
        echo "Starting installing botnet..."
        sleep 2
        git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet

        echo "Enter commands:"
        echo ""
        echo "cd telegram-raid-botnet"
        echo "python3.9 main.py"
        else
            printf "\033c"
            echo "Please launch autoinstall with root"
            exit 1;
    fi
elif [[ "$OSTYPE" =~ ^WSL2 ]]; then
    if [[ $(whoami) = 'root' ]]; then
        clear
        echo "Join in our Telegram channels : @huis_bn & @bruhnet"
        echo "Detected OS : $(cat /etc/*release | grep ^NAME)"
        echo "Packet Manager : Apt"
        echo "Installings packages for your system..."
        sleep 5
        apt install -y ffmpeg youtube-dl git
        pip3 install -U $req
        pip3 install git+https://github.com/pytgcalls/pytgcalls -U
        clear
        echo "All packages installed!"
        sleep 2
        clear
        echo "Starting installing botnet..."
        sleep 2
        cd ~ && git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet && cd telegram-raid-botnet && python main.py
        else
            clear
            echo "Please launch autoinstall with root"
            exit 1;
fi
elif cat /etc/*release | grep ^NAME | grep "Arch Linux" || cat /etc/*release | grep ^NAME | grep "Artix Linux" || cat /etc/*release | grep ^NAME | grep Antix || cat /etc/*release | grep ^NAME | grep Manjaro || cat /etc/*release | grep ^NAME | grep Parabola; then
    if [[ $(whoami) = 'root' ]]; then
        clear
        echo "Join in our Telegram channels : @huis_bn & @bruhnet"
        echo "Detected OS : $(cat /etc/*release | grep ^NAME)"
        echo "Packet Manager : Pacman"
        echo "Installings packages for your system..."
        sleep 5
        yum install -y ffmpeg
        pip3 install -U $req
        pip3 install git+https://github.com/pytgcalls/pytgcalls -U
        clear
        echo "All packages installed!"
        sleep 2
        clear
        echo "Starting installing botnet..."
        sleep 2
        cd ~ && git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet && cd telegram-raid-botnet && python main.py
        else
            clear
            echo "Please launch autoinstall with root"
            exit 1;
    fi
elif  cat /etc/*release | grep ^NAME | grep Ubuntu || cat /etc/*release | grep ^NAME | grep Debian || cat /etc/*release | grep ^NAME | grep Mint || cat /etc/*release | grep ^NAME | grep Mint; then
    if [[ $(whoami) = 'root' ]]; then
        clear
        echo "Join in our Telegram channels : @huis_bn & @bruhnet"
        echo "Detected OS : $(cat /etc/*release | grep ^NAME)"
        echo "Packet Manager : Apt"
        echo "Installings packages for your system..."
        sleep 5
        apt update -y
        apt install -y ffmpeg git software-properties-common curl 
        add-apt-repository ppa:deadsnakes/ppa -y
        apt install -y python3.10 python3.10-distutils
        curl https://bootstrap.pypa.io/get-pip.py | python3.10
        curl -sL https://deb.nodesource.com/setup_17.x | sudo bash -
        sudo apt-get install -y nodejs
        python3.10 -m pip install -U $req 
        python3.10 -m pip install git+https://github.com/pytgcalls/pytgcalls -U
        clear
        echo "All packages installed!"
        sleep 2
        clear
        echo "Starting installing botnet..."
        sleep 2
        cd ~ && git clone https://github.com/json1c/telegram-raid-botnet.git ~/telegram-raid-botnet && cd telegram-raid-botnet && python3.10 main.py
    else
        clear
        echo "Please launch autoinstall with root"        
        exit 1;
    fi
    else    
        clear
        echo "Something went wrong, try to install botnet from instruction"
        exit 1;    
    fi
else
    clear
    echo "OS NOT DETECTED, couldn't install packages for your system..."
    echo "Try to install botnet from instruction"
    exit 1;
fi

exit 0
