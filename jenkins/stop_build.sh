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

# Start variables

function help() {
  cat<<-EOM

  NAME:
      stop_build.sh

  RESUMO:
      Realiza o cancelameto de um job cadastrado no Jenkins

  DESCRIÇÃO:
      stop_build <JOB_NUMBER>
EOM
}
# cancelBuild(<NUMERO_DO_JOB>) - Função para realizar o cancelamento de um job em andamento
# Sobre:
# Recebe como parâmetro o número do JOB, inicialmente valida se é um número válido,
# posteriormente segue com o request, valida o http code (302).

function cancelBuild() {
  integer='^[0-9]+$'
  number_job=$1

  if [[ $number_job =~ $integer ]]
  then
    jenkins_crumb=$(curl -s -X GET "http://$Jenkins_host/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)" --user "$User_api:$User_token")
    response=$(curl -i -s -m 5 --netrc -H "$jenkins_crumb" -X POST "http://$Jenkins_host/job/$Job_name/$number_job/stop?token=$Job_token&delay=0" --user "$User_api:$User_token")

    saveLog 'CANCEL' "$response"

    http_code=$(echo "$response" | grep HTTP | awk '{print $2}')

    if [[ $http_code == '302' ]]
    then
      echo "STOPPED"
    elif [[ ! -z $http_code && $http_code != '200' ]]
    then
      echo "Error - $http_code - check job number configuration";
      exit 1
    else
      echo "Error - time-out or invalid host - '$Jenkins_host'"
      exit 1
    fi
  else
    echo "Error - Not valid job number value"
    exit 1
  fi
}

case $1 in
  help) help;;
  --help) help;;
  *) cancelBuild $2;;
esac