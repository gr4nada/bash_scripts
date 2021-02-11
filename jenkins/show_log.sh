#!/bin/bash

# start variables
path_log="/var/log/api"
time_stamp=$(date +%Y-%m-%d)

function start_follow(){
    # follow -> output appended data as the file grows;
    tail -f -n 5000 $path_log/"$time_stamp"_api.log
}

function help() {
 cat<<-EOM

  NAME:
      show_log - show the output appended data as the api log file.

  USAGE:
      show_log
      show_log [help|--help] 

EOM
}

case $1 in
  help) help;;
  --help) help;;
  *) start_follow;;
esac