# Exit immediatly on error
set -e

frameworkName=$1
moduleName=$2
customParameters=`echo $3 $4 $5`

# Setup custom-parameters for generamba
if [[ "" != $customParameters ]]
then
  customParameters="--custom-parameters="$customParameters
fi

cd $frameworkName
generamba gen $moduleName alfa_viper_swift $customParameters
cd ..
