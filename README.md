# Nginx Proxy

This provides an Nginx based Docker image that can be used to proxy requests to given endpoints (based on server name).

## Usage

The image requires both the desired `LISTEN_PORT` of the Nginx service, and the `PROXY_HOSTS` endpoint configuration - both supplied as enviornemnt variables.
The configuration is supplied as a Base64-encoded JSON array conforming to the following template:

```json
[
  {
    "name": "name-of-endpoint",
    "server_name": "www.server-name.com",
    "proxy_url": "https://www.proxy-url.com",
    "proxy_host": "www.proxy-host.com",
    "resolver": "1.1.1.1",
    "timeout": 29,
    "location_extra": "proxy_set_header x-api-key KEY;"
  }
]
```

## Example

Below is an example which highlights defining a static, regex-based and catch-all endpoint proxy service.

With a configuration stored in a file entitled `config.json`.

```json
[
  {
    "name": "google",
    "server_name": "www.my-google-proxy.com",
    "proxy_url": "https://www.google.com",
    "proxy_host": "www.google.com",
    "resolver": "1.1.1.1",
    "timeout": 29,
    "location_extra": ""
  },
  {
    "name": "yahoo",
    "server_name": "~^www\\.(?<subdomain>.+)-yahoo\\.com$",
    "proxy_url": "https://$subdomain.yahoo.com",
    "proxy_host": "$subdomain.yahoo.com",
    "resolver": "1.1.1.1",
    "timeout": 29,
    "location_extra": ""
  },
  {
    "name": "default",
    "server_name": "_",
    "proxy_url": "https://www.mybuilder.com",
    "proxy_host": "www.mybuilder.com",
    "resolver": "1.1.1.1",
    "timeout": 29,
    "location_extra": ""
  }
]
```

```sh
docker run --rm -it \
  -p 80:80 \
  -e LISTEN_PORT=80 \
  -e PROXY_HOSTS=$(cat config.json | base64) \
    ghcr.io/mybuilder/nginx-proxy
```
