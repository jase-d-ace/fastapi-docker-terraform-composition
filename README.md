# FastAPI + Docker + Terraform
This repo holds a practice infrastructure app where a very, VERY simple FastAPI server that only serves a single json object on `"/"` is dockerized via the `Dockerfile` and then provisioned with AWS EC2 resources via a Terraform configuration in `main.tf`

In full disclosure I have never EVER touched infrastructure work like this before and am using a combination of HashiCorp tutorials, Docker documentation, and a healthy side of ChatGPT to put this barebones app together.

## What I've learned from all of my research
* FastAPI is very lightweight and can be quickly configured and written to serve JSON and uses the query string to manage route parameters just like Django does. Run a FastAPI app using `fastapi dev path/to/main.py
* a `Dockerfile` contains all of the relevant information to ensure that whatever you use to develop locally can be easily packaged up and stored as configuration and then replicated either on another engineer's laptop, or, in the case of this practice app, on provisioned cloud infrastructure so that no one can ever hide behind "works on my machine". I learned how to push a local Docker image to Dockerhub using [this SO queston](https://stackoverflow.com/questions/28349392/how-to-push-a-docker-image-to-a-private-repository)
* a `main.tf` file is what manages your actual cloud infrastructure and allows you to spin up and tear down the infrastructure on which you host your Dockerized application
* EC2 instances need to be configured to explicitly allow SSH access via the `aws_security_group` resource configuration in `main.tf`
* EC2 instances are used to host web servers (like a very small one-route FastAPI server) and you query it just as you would any other database/server.
* In this very quick example, I queried the public IP of the EC2 instance directly, but I have no doubt that in production this instance would have its own DNS and MANY more security protections than I've put in place.
* If I had more time, I would probably look into how to use terraform to compose a full network of infrastructure whose instances can all talk to each other or interact.
* I've confirmed that this EC2 instance runs as expected by using another practice React app to make a request to this back end and render the very simple JSON object on screen.
* The FastAPI app in this repo for now only has one route. I would next look into how to build a full web server that handles more complicated business logic. For now, I chose to focus on getting the app fully dockerized and provisioned on AWS because that was where I had no knowledge. I also have no knowledge of FastAPI, but using Python as a JSON web server is something that I'm more familiar with. Provisioning infrastructure like this was completely alien to me until just now. It still is very alien to me, but at least I know what to look for in an infrastructure.
* Obviously this is a very small app that has straightforward business logic (it just responds to a single get request with a single JSON oobject). But I'd love to learn more about how else to expand the infrastructure network and know more about how else we can take advantage of infrastructure-as-code.
* One thing that's missing from the `main.tf` config file is that upon running `terraform apply`, the EC2 instance is created, and docker is successfully installed, but I couldn't get the container to pull the image from Docker Hub upon launch so I had to SSH into it manually and pull it.

## Works Cited
* [HashiCorp Tutorial](https://developer.hashicorp.com/terraform/tutorials/aws-get-started) for AWS Terraform provisioning
* [AWS Docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-prerequisites.html?icmpid=docs_ec2_console#ec2-instance-connect-setup-security-group) to figure out SSH issues and launching
* ChatGPT to walk me through orchestrating FastAPI, Docker, and Terraform