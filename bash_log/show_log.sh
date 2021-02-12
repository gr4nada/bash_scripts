#!/bin/bash
#
# Author:
#        _                             _             
#       | |                           (_)            
#     __| | _ __    __ _  _ __   __ _  _  ___   ___  
#    / _` || '_ \  / _` || '__| / _` || |/ __| / _ \ 
#   | (_| || |_) || (_| || |   | (_| || |\__ \| (_) |
#    \__,_|| .__/  \__,_||_|    \__,_||_||___/ \___/ 
#          | |                                       
#          |_|                                       
#                      email:  

# start variables
path_log="/home/$USER/logs/api"
time_stamp=$(date +%Y-%m-%d)

function help() {
 cat<<-EOM

  NAME:
      show_log - show the output appended data as the api log file.

  USAGE:
      show_log
      show_log [help|--help] 

EOM
}

function start_follow(){
    # follow -> output appended data as the file grows;
    tail -f -n 5000 $path_log/"$time_stamp"_api.log
}

case $1 in
  help) help;;
  --help) help;;
  *) start_follow;;
esac