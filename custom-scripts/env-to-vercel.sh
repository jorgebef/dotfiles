#!/bin/bash

# verify that we have correct number of arguments
if [ ! $# -eq 2 ];then
echo "| ============================================================================== |"
echo "|                                                                                |"
echo "| Please provide both a path to the current .env file and a specific environment |"
echo "|                                                                                |"
echo "| # Usage:                                                                       |"
echo "| # ./env-to-vercel.sh <path-to-.env> <production | preview | development>       |"
echo "|                                                                                |"
echo "| ============================================================================== |"
exit 1
fi

set -a
. $1
set +a
env_vars=`cat "$1" | sed s/=.*//g`

for key in $(echo $env_vars);do

if [[ $key =~ ^#.* ]];then
  echo "Skipping the commented value" - $key

  else
    echo "Uploading" - $key
    # sleep 2 #For vercel API
    vercel env rm ${key} $2 -y
    # WARNING use 'printf' instead of 'echo -n' which for whatever reason
    # adds the trailing newline... weird...
    printf "${!key}" | vercel env add $key $2
fi

done

echo "| ===================================== |"
echo "| CHECK IF ALL VALUES ARE CORRECT       |"
echo "| SOMETIMES AN EXTRA \n is added!!!!!!! |"
echo "| ===================================== |"

exit 0;
