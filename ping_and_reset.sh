#!/bin/bash

# usage:
# ./ping_and_reset [<URL>]
#
# This script pings URL. If too few pongs return, reset
# the wifi connection.
# URL's default value is google.com

MAX_ACCEPTABLE_LOSS=50 #percent

if [ -z ${1+x} ]; then
  URL=google.com;
else
  URL=$1;
fi

# Measure Internet connectivity by connection to @URL
while true
do
  regex="([0-9]+)% packet loss"
  ping -w 5 $URL |
    while IFS= read -r line
    do
        [[ $line =~ $regex ]]
        packet_loss_percent="${BASH_REMATCH[1]}";
        if [ $((packet_loss_percent)) -ge "$MAX_ACCEPTABLE_LOSS" ]
        then
          # If we disconnect. Reset wifi.
          echo 'resetting!';
          nmcli nm wifi off;
          sleep 1;
          nmcli nm wifi on;
          sleep 5;
        fi
    done
done

