#!/bin/sh

rm -fr /etc/nginx/conf.d/*

for proxy in $(echo "${PROXY_HOSTS}" | base64 -d | jq -r '.[] | @base64'); do
    _jq() { echo ${proxy} | base64 -d | jq -r ${1}; }

    NAME=$(_jq '.name')

    cp /template.conf /etc/nginx/conf.d/$NAME.conf
    
    sed -i "s|##LISTEN_PORT##|${LISTEN_PORT}|g"              /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##SERVER_NAME##|$(_jq '.server_name')|g"       /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##RESOLVER##|$(_jq '.resolver')|g"             /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##PROXY_URL##|$(_jq '.proxy_url')|g"           /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##PROXY_HOST##|$(_jq '.proxy_host')|g"         /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##TIMEOUT##|$(_jq '.timeout')|g"               /etc/nginx/conf.d/$NAME.conf
    sed -i "s|##LOCATION_EXTRA##|$(_jq '.location_extra')|g" /etc/nginx/conf.d/$NAME.conf

    echo "Compiled $NAME"
done
