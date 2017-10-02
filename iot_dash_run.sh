#!/bin/bash

workdir=`pwd`

aws_region=`cat ${workdir}/share/sys_config.json | jq -r '.geo.aws_region'`
api_url=`cat ${workdir}/share/sys_config.json | jq -r '.api.api_url'`
iot_endpoint=`cat ${workdir}/share/sys_config.json | jq -r '.identity.iot_endpoint'`
cognito_identity_pool=`cat ${workdir}/share/sys_config.json | jq -r '.identity.cognito_identity_pool'`

cd ./dashboard

cp ./config.dist.js ./config.js
sed -i "s/awsRegion: '.*'/awsRegion: '${aws_region}'/" -- ./config.js
sed -i "s/apiUrl: '.*'/apiUrl: '${api_rul}'/" -- ./config.js
sed -i "s/iotEndpoint: '.*'/iotEndpoint: '${iot_endpoint}'/" -- ./config.js
sed -i "s/cognitoIdentityPool: '.*'/cognitoIdentityPool: '${cognito_identity_pool}'/" -- ./config.js
echo 
echo "CONFIG:"
cat ./config.js
echo 
npm run build
mkdir ${workdir}/share/dashboard_dist
cp ./dist/* ${workdir}/share/dashboard_dist

cd -
