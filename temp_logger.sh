#!/bin/bash

read -p 'Minutes to observe Raspberry Pi Temperature: ' timevar
read -p 'Seconds between observations: ' freqvar

otime=$(( $timevar * 60 / $freqvar ))

timestamp=$(date +%F_%H%M%S)
echo "$timestamp - Start to record Raspberry Pi Temp for $timevar minutes ($otime data points)"
echo "$timevar Minute Temperature Log - $(date)" >/home/pi/logs/temp_log_$timestamp.txt

for i in $(eval echo {1..$otime})
do
	tstamp=$(date +%H:%M:%S)
	temp=$(/opt/vc/bin/vcgencmd measure_temp)
	temp=${temp:5:16}
	echo "$tstamp - $temp" >>/home/pi/logs/temp_log_$timestamp.txt
	tail -1 /home/pi/logs/temp_log_$timestamp.txt
	sleep $freqvar
done
echo "Finished Recording Temperature"
