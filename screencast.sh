#!/bin/bash

########################################################################
# This script is created by metalx1000 on youtube, I just make some    #
# changes to fit in my system environment.                             #
# link: https://www.youtube.com/watch?v=FhWXVA7OI6E                    #
# how to use:                                                          #
# 1. make this script executatble "chmod +x screencast.sh"             #
# 2. execute it "./screencast.sh"                                      #
# 3. name the video that will be vast on your screen                   #
# 4. select the window/area by click your mouse to start the recording #
# 5. press ctrl-c to exit the casting                                  #
########################################################################

## go to the video directory
cd $HOME/Videos/

## using "zenity" to prompt out a dialog box for save the name of the vidoe file that will be recorded
SavePath=$(zenity --file-selection --save --confirm-overwrite)
echo "Saving video to $szSavePath"

## use "xwininfo -frame" command to get the display information, such as height, weight .....
INFO=$(xwininfo -frame)

WIN_GEO=$(echo "$INFO"|grep -e "Height:" -e "Width:"|cut -d\: -f2|tr "\n" " "|awk '{print $1 "x" $2}')
WIN_POS=$(echo "$INFO"|grep "upper-left"|head -n 2|cut -d\: -f2|tr "\n" " "|awk '{print $1 "," $2}')


## the screen will be cast by the "ffmpeg" command, 
## feel free to change anything below to suit yourself, such as the format of the video(I used the MKV format)
ffmpeg -f pulse -i default -f x11grab -s $WIN_GEO -r 30 -i :0.0+$WIN_POS -r 30 -acodec pcm_s16le -qscale 0 "$SavePath.mkv"

#ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -s $WIN_GEO -r 30 -i :0.0+$WIN_POS -r 30 -acodec pcm_s16le -sameq "$SavePath.mkv"

echo "$WIN_GEO -i :0.0+$WIN_POS -acodec"
echo "$WIN_POS"
