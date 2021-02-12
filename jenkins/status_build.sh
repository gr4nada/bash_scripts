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
BUILD_NUMBER="";
STATUS="None";
COMPLETE="false";

function is_jenkins_job_complete() {
    API_RESPONSE=`curl ${1}`;
    STATUS=`echo "${API_RESPONSE}" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["result"]'`;
    BUILD_NUMBER=`echo "${API_RESPONSE}" | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["id"]'`;

    if [ ${STATUS} != "None" ]; then
        COMPLETE='true';
    else
        COMPLETE='false';
    fi
}

function status_build() {
    # statusBuild(<NUMERO_DO_JOB>) - Função para realizar a consulta do status de um job.
    # Sobre:
    # Recebe como parâmetro o número do JOB, inicialmente valida se é um número válido,
    # posteriormente segue com o request, valida o http code (200),
    # depois valida se o job está em execução ou se já terminou, retornando um dos status:
    # SUCCESS, ABORTED, FAILURE, UNSTABLE ou BUILDIN

    integer='^[0-9]+$'
    number_job=$1

    if [[ $number_job =~ $integer ]]
    then
        response=$(curl -i -s -m 5 --netrc -X GET "http://$Jenkins_host/job/$Job_name/$number_job/api/json?pretty=true" --user "$User_api:$User_token")
        http_code=$(echo "$response" | grep HTTP | awk '{print $2}')

        saveLog 'STATUS' "$response"

        if [[ $http_code == '200' ]]
        then
        if [[ $response == *"\"building\" : true"* ]]
        then
            echo "BUILDING"
        else
            echo "$response" | grep '"result"' | cut -d\" -f4
        fi

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

function help() {
  cat<<-EOM

  NAME
      jenkinsAPI.sh

  USAGE
      Realiza a inicialização e obtém status remotamente de um job cadastrado no Jenkins

  DESCRIPTION
      jenkinsAPI.sh start <PARAMETRO> ou nulo - Realiza o start remoto do job (parametrizado ou não) e retorna o número gerado.
      jenkinsAPI.sh status <NUMERO_DO_JOB> - Consulta do status de um job.
      jenkinsAPI.sh cancel <NUMERO_DO_JOB> - Cancelamento de um job em andamento

EOM
}

case $1 in
  status) statusBuild $2;;
  *) help;;
esac

isJenkinsJobComplete "https://myhost/myjob/lastBuild/api/json"
echo "Build #${BUILD_NUMBER} is complete: ${COMPLETE}, status is: ${STATUS}";
