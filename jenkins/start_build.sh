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

# Start Variables
# TODO: fazer a leitura atraves do arquivo de configuracao
Jenkins_host="127.0.0.1:8080"
Job_name="Teste%20da%20API"
User_api="granada"
User_token="11f2d6b20731754c7f28b6be8239884faf"
file_path="/home/$USER/"
filename="scenarios.txt"
parameters=""
# TODO fazer o array com o nome dos parametros
name_parameters="param_1,param2,param_3,param_4"

function get_parameters() {
  # get parameters from file
    while IFS=$':' read name param description;
    do
      # find parameters from scenario name 
      if [ $scenario == $name ]; then
         # split string into array
         IFS=$',' read -r -a array<<< $param
          tam=${#array}
          # build the command with parameters
          for (( count=0; count<$tam; count++ ))do
                # echo "${array[$count]}"
                parameters=$parameters"--data param_$((count+1))=${array[$count]} "
                echo $parameters
          done
      fi
    done < $file_paths$filename
}

function help() {
  cat<<-EOM

  NOME
      jenkinsAPI.sh

  RESUMO
      Realiza a inicialização e obtém status remotamente de um job cadastrado no Jenkins

  DESCRIÇÃO
      start_build <CENARIO>

EOM
}

# test to validate if there are any arguments
if [[ -z "$1" ]]; then
  help
  exit 1
fi

count=1
# correctly getting the input strings
for arg in "$@"; do
  if [ "1" -eq "$count" ]; then
          scenario=$arg
  fi
  if [ "2" -eq "$count" ]; then
          save_log.sh "ERROR" "many arguments"
          exit 1
  fi
  ((count++))
done

case $1 in
  help) help;;
  --help) help;;
  *) get_parameters $1;; 
esac
echo $parameters
# Jenkins API command
                # http://127.0.0.1:8080//job/Teste%20da%20API/buildWithParameters --user granada:11f2d6b20731754c7f28b6be8239884faf --data param_1=TRUE --data param_2=FALSE --data param_3=FALSE --data param_4=TRUE
response=$(curl "http://$Jenkins_host//job/$Job_name/buildWithParameters" --user "$User_api:$User_token $parameters")
echo "http://$Jenkins_host//job/$Job_name/buildWithParameters" --user "$User_api:$User_token $parameters"
save_log.sh 'INFO' "$response"

http_code=$(echo "$response" | grep HTTP | awk '{print $2}')

if [[ $http_code == '201' ]]
then
  number_queue=$(echo "$response" | grep Location | cut -d\/ -f6)
  status_queue=$(sleep 3;curl -i -s -m 5 --netrc -X GET "http://$Jenkins_host/queue/item/$number_queue/api/json?pretty=true" --user "$User_api:$User_token")

  save_log.sh 'INFO' "$status_queue"

  http_code=$(echo "$status_queue" | grep HTTP | awk '{print $2}')

  if [[ $http_code == '200' ]]
  then
    if [[ $status_queue == *"\"blocked\" : true"* ]]
    then
      save_log.sh 'INFO' "$status_queue" |  grep '"why"' | cut -d\" -f4
      exit 1
    else
      save_log.sh 'INFO' "$status_queue" |  grep '"number"' | awk '{print $3}' | sed 's/,//g'
    fi
  elif [[ ! -z $http_code && $http_code != '200' ]]
  then
    save_log.sh 'ERROR' "$http_code - check queue number configuration";
    exit 1
  else
    save_log.sh 'ERROR' "time-out or invalid host - '$Jenkins_host'"
    exit 1
  fi

elif [[ ! -z $http_code && $http_code != '201' ]]
then
  save_log.sh 'ERROR' "$http_code - check job data configuration";
  exit 1
else
  save_log.sh 'ERROR' "time-out or invalid host - '$Jenkins_host'"
  exit 1
fi
