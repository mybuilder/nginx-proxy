FROM nginx:1.21.3-alpine

COPY default.conf /etc/nginx/conf.d/default.conf

CMD sed -i "s|##LISTEN_PORT##|${LISTEN_PORT}|g"         /etc/nginx/conf.d/default.conf;   \
    sed -i "s|##RESOLVER##|${RESOLVER}|g"               /etc/nginx/conf.d/default.conf;   \
    sed -i "s|##PROXY_URL##|${PROXY_URL}|g"             /etc/nginx/conf.d/default.conf;   \
    sed -i "s|##PROXY_HOST##|${PROXY_HOST}|g"           /etc/nginx/conf.d/default.conf;   \
    sed -i "s|##TIMEOUT##|${TIMEOUT}|g"                 /etc/nginx/conf.d/default.conf;   \
    sed -i "s|##LOCATION_EXTRA##|${LOCATION_EXTRA:-}|g" /etc/nginx/conf.d/default.conf && \
    nginx -g "daemon off;"
