# Telegram proxy server hosted in AWS

One click deploy IaC to run a Telegram proxy server in AWS.

### Steps to deploy

1. Clone this repo
2. cd into [aws-infra](./aws-infra/)
3. `cp sample.env .env`
4. Edit `.env` to have actual AWS secrets values
5. `set -a`
6. `source .env`
7. `terraform plan -out plan.tfplan`
8. `terraform apply plan.tfplan`

### Using the Proxy server

1. Open the public IP of the EC2 in a browser
2. Use the connection details shown there (IP, port, secret) in telegram client to connect to the proxy server
3. Bypass censorship and use Telegram

### Additional Details.

The EC2 instance is deployed in Thailand (`ap-southeast-7`). Change the region in [aws-infra/main.tf](./aws-infra/main.tf#2) if you want it deployed somewhere else. Also feel free 2 set the AZ in [aws-infra/subnet.tf](./aws-infra/subnet.tf) if you want.
