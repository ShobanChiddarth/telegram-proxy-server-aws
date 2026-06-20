# Docker image to expose Telegram proxy server's connection details over a HTTP endpoint

This container assumes

1. It is being run in a EC2 instance in a public subnet with a public IP
2. `/data` from `telegrammessenger/proxy:latest` is mounted and accessible

## Sample run command

```
docker run -d -v /data:/data -p 0.0.0.0:8000:8000 shobanchiddarth/tproxy-server-expose-details:1.0.0
```
