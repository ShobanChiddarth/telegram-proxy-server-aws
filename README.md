# Telegram proxy server hosted in AWS

The folder `aws-infra-minimal` contains the minimum amount of infra required to launch just one proxy server. The other folder `aws-infra` has laid the foundation to scale the proxy infra up to support a lot of users. It has a NLB, auto scaling group, with public private instances.

## `aws-infra-minimal`

One click deploy minimal IaC to run a Telegram proxy server in AWS.

### Steps to deploy

1. Clone this repo
2. cd into [aws-infra/](./aws-infra/)
3. `cp sample.env .env`
4. Edit `.env` to have actual AWS secrets values
5. `set -a`
6. `source .env`
7. `terraform plan -out plan.tfplan`
8. `terraform apply plan.tfplan`
9. Open the public IP of the EC2 in a browser for proxy server connection details.

### Using the Proxy server

1. Open the public IP of the EC2 in a browser. (This is made possible using the containerized FastAPI application in [tproxy-server-expose-details/](./tproxy-server-expose-details/))
2. Use the connection details shown there (IP, port, secret) in telegram client to connect to the proxy server
3. Bypass censorship and use Telegram

### Additional Details.

The EC2 instance is deployed in Thailand (`ap-southeast-7`). Change the region in [aws-infra/main.tf](./aws-infra/main.tf#2) if you want it deployed somewhere else. Also feel free 2 set the AZ in [aws-infra/subnet.tf](./aws-infra/subnet.tf) if you want.

> NOTE: Earlier Thailand worked but now it is not working. So I changed it to Singapore `ap-southeast-1` in `aws-infra`

## `aws-infra` (under construction)

Steps to deploy are the same. For connecting to the server from the client, enter NLB dns name instead of public IPV4 address. And there is no app running on :80 to expose the details for connection. See terraform outputs instead.

This project has been paused because I am working on [somehting else](https://www.linkedin.com/posts/shobanchiddarth_siem-wazuh-aws-share-7477956807253118976-Kk8p/) right now.

In the future I will add
- Fine tuned auto scaling
- Lamdba based cost monitoring API
- Lambda based management API for
   - Manual overriding of Auto Scaling values
   - Retrieve and update proxy server secret
   - QR Code generation based on proxy connection details (frontend work)
   - Shut down / reboot bastion
   - Proxy Server connectivity check and notification

For now, it "just works" and deploys a NLB with 1 auto scaled server.

