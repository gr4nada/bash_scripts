#!/bin/bash

log_path="~/logs/api"

      
function save_log() {
  echo "$(date +%T) - $log_level - $msg" >> $log_path/"$time_stamp"_api.log
}

function create_header(){
  echo "" >> $log_path/"$time_stamp"_api.log
  echo "$(date +%T) - [$msg] ==========================================" >> $log_path/"$time_stamp"_api.log
}

function help() {
  cat<<-EOM

  NAME:
      save_log - Create the system log output.

  USAGE:
      save_log <TYPE> <MESSAGE>

  DESCRIPTION:
      Save information about system on the logfile.

      Options:
        TYPE  [EVENT|INFO|ERROR|WARN] 
                EVENT -  Create a tag event on LOG. The message in this case is a event title. 
                INFO - Log INFO level.
                ERROR - Log ERROR level.
                WARN - Log WARN level.
                
EOM
}

# start variables
time_stamp=""
count=1
log_level=""

# test to validate if there are any arguments
if [[ -z "$1" ]]; then
  help
fi

# correctly getting the input strings
for arg in "$@"; do
  if [ "1" -eq "$count" ]; then
          log_level=$arg
  fi
  if [ "2" -eq "$count" ]; then
          msg=$arg
  fi
  ((count++))
done

mkdir -p $log_path
time_stamp=$(date +%Y-%m-%d)

case $log_level in
  EVENT) create_header $msg;;
  INFO) save_log $msg;;
  ERROR) save_log $msg;;
  WARN) save_log $msg;;
  *) help;;
esac
