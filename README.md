# Nginx Proxy

This provides an Nginx based Docker image that can be used to proxy requests to a given endpoint. E.g.:

```
docker run --rm -it \
  -p 80:80 \
  -e LISTEN_PORT=80 \
  -e RESOLVER=1.1.1.1 \
  -e PROXY_HOST=www.google.com \
  -e PROXY_URL=https://www.google.com \
  -e TIMEOUT=29 \
    mybuilder/nginx-proxy
```
