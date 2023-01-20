#!/bin/bash

############################## 
#	    DISK
##############################
trap 'update' 5

mpd(){
	song="$(mpc current)"
	status="$(mpc status | grep paused | awk '{print $1}')"
	echo -e "$song"
}

hdd() {
	hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $2}')"
	    echo -e " $hdd"
    }
##############################
#	    RAM
##############################

mem() {
used="$(free -h | grep Mem: | awk '{print $3}')"
#total="$(free | grep Mem: | awk '{print $2}')"

#totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"

ram="$used"

echo $ram
}
##############################	
#	    CPU
##############################

cpu() {
	  read cpu a b c previdle rest < /proc/stat
	    prevtotal=$((a+b+c+previdle))
	      sleep 0.5
	        read cpu a b c idle rest < /proc/stat
		  total=$((a+b+c+idle))
		    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
		      echo -e "  $cpu%"
	      }
##############################
#	    VOLUME
##############################
vol() {	
	vol="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')"
	volstat=$(pamixer --get-volume)

vol=$(echo "$volstat")

if [ "$vol" -gt "70" ]; then
	volicon=" "
elif [ "$vol" -eq "0" ]; then
	volicon="婢"
elif [ "$vol" -lt "30" ]; then
	volicon=""
else
	volicon="墳"
fi

	echo -e "$volicon $vol"
}

## BATTERY
# bat() {
# batstat="$(cat /sys/class/power_supply/BAT0/status)"
# battery="$(cat /sys/class/power_supply/BAT0/capacity)"
#     if [ $batstat = 'Unknown' ]; then
#     batstat=""
#     elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
#     batstat=""
#     elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
#     batstat=""
#     elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
#     batstat=""
#     elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
#     batstat=""
#     elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
#     batstat=""
#     elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
#     batstat=""
# fi

# echo "$batstat  $battery"
# }

network() {
wifi="$(ip a | grep wlp2s0 | grep inet | wc -l)"
wire="$(ip a | grep eth0 | grep inet | wc -l)"
wifi="$(ip a | grep wlp1s0 | grep inet | wc -l)"
wire="$(ip a | grep enp1s0 | grep inet | wc -l)"
if [ $wire = 0 ]; then 
    echo ""
elif [ $wifi = 1 ]; then
    echo " "
else 
    echo "睊"
fi
}
update(){
	echo "$(win) $(mpd) $(cpu) +@bg=1; +@fg=1;  $(mem) +@bg=2;   $(hdd) +@bg=4; $(vol) +@bg=5; $(network)"
    wait
}    
while :; do     
    #echo "$(cpu)| $(mem)| $(pkgs)|﯁ $(upgrades)| $(hdd)| $(vpn)| $(vol)|$(bat)|$(weather) $(temp)| $(network)|"
		update
		~/.config/spectrwm/scripts/trayer_follows_ws.sh
    sleep 2 &
    wait
done
