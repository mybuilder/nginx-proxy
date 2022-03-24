FROM nginx:1.21.3-alpine

RUN apk add jq

COPY compile.sh /docker-entrypoint.d/40-compile.sh
COPY template.conf /template.conf
