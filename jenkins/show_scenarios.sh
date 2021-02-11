#!/bin/bash

function read_file(){    
    while IFS=$':' read name parameters description;
    do echo "$name - $description"; 
    done < scenarios.tx
}

function help() {
 cat<<-EOM
  NAME:
      show_scenario - show the scenarios log output.

  USAGE:
      show_scenario
      show_scenario [help|--help] 
EOM
}

case $1 in
  help) help;;
  --help) help;;
  *) read_file;;
esac