#!/bin/bash

#--------------------constant-variables-------------------

dependencies=("base-devel" "xorg-server" "xorg-xinit" "libx11" "libxinerama" "libxft" "webkit2gtk" "dmenu" "ttf-hack" "feh" "python-pywal" "picom" "sl" "neofetch") # all the packages needed for the installation 
dwm_git="https://github.com/savith12321/dwm" # source of the dwm; if you want another version of dwm change the link here 
st_git="https://github.com/savith12321/st" # source of st (simple terminal); if yo want another version of st (simple terminal) change the link here

#-------------------checking-and-installing-packages-------------------

for i in ${dependencies[@]}
do 
  check=$( ( pacman -Qi $i | sort ) 2>&1 )
  if [ "$check" == "error: package '$i' was not found" ]
  then 
    echo "Installing package '$i'..."
    sudo pacman --noconfirm -S $i > /dev/null
  else
    echo "package "$i" already installed..."
  fi
done

#--------------------cloning-st-and-dwm-------------------

mkdir $HOME/suckless 
git clone $dwm_git $HOME/suckless/dwm 
git clone $st_git $HOME/suckless/st 

#--------------------building-the-packages--------------------
################
#------dwm-----#
################

cd $HOME/suckless/dwm && sudo make clean install 

##############
#-----st-----#
##############

cd $HOME/suckless/st && sudo make clean install 

#--------------------copying-config-files---------------------
