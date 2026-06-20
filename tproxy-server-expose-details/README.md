# Docker image to expose Telegram proxy server's connection details over a HTTP endpoint

This container assumes

1. It is being run in a EC2 instance in a public subnet with a public IP
2. `/data` from `telegrammessenger/proxy:latest` is mounted and accessible
