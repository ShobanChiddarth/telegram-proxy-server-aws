# Docker image to expose Telegram proxy server's connection details over a HTTP endpoint

This container assumes

1. It is being run in a EC2 instance in a public subnet with a public IP
2. `/data` from `telegrammessenger/proxy:latest` is mounted and accessible

When GET on any URL, it returns

```json
{
    "ip": "<public IP of EC2 instance> (uses ipify.org)", // will later remove this as someone gotta know the public IP of the EC2 in order to access this page
    "port": "443",
    "secret": "<content from the file `/data/secret`" 
}
```

This is supposed to be used with [telegrammessenger/proxy](https://hub.docker.com/r/telegrammessenger/proxy).
`telegrammessenger/proxy` has the secret stored in `/data/secret` inside the container, so volume map it to `data` outside that container
and map it back into this container.

## Sample run command

```
docker run -d -p 0.0.0.0:443:443 --name=mtproto-proxy --restart=always -v /data:/data telegrammessenger/proxy:latest
docker run -d -v /data:/data -p 0.0.0.0:80:8000 shobanchiddarth/tproxy-server-expose-details:1.0.0
```
