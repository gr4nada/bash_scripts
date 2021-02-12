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
file_path="/home/$USER/"
filename="scenarios.txt"

function help() {
 cat<<-EOM
  NAME:
      show_scenario - show the scenarios log output.

  USAGE:
      show_scenario
      show_scenario [help|--help] 
EOM
}

function read_file(){    
    while IFS=$':' read name parameters description;
    do echo "$name - $description"; 
    done < $file_paths$filename
}

case $1 in
  help) help;;
  --help) help;;
  *) read_file;;
esac