# FastAPI + Docker + Terraform
This repo holds a practice infrastructure app where a very, VERY simple FastAPI server that only serves a single json object on `"/"` is dockerized via the `Dockerfile` and then provisioned with AWS EC2 resources via a Terraform configuration in `main.tf`

In full disclosure I have never EVER touched infrastructure work like this before and am using a combination of HashiCorp tutorials, Docker documentation, and a healthy side of ChatGPT to put this barebones app together.

## What I've learned from all of my research
* FastAPI is very lightweight and can be quickly configured and written to serve JSON and uses the query string to manage route parameters just like Django does. Run a FastAPI app using `fastapi dev path/to/main.py
* a `Dockerfile` contains all of the relevant information to ensure that whatever you use to develop locally can be easily packaged up and stored as configuration and then replicated either on another engineer's laptop, or, in the case of this practice app, on provisioned cloud infrastructure so that no one can ever hide behind "works on my machine". I learned how to push a local Docker image to Dockerhub using [this SO queston](https://stackoverflow.com/questions/28349392/how-to-push-a-docker-image-to-a-private-repository)
* a `main.tf` file is what manages your actual cloud infrastructure and allows you to spin up and tear down the infrastructure on which you host your Dockerized application
* EC2 instances need to be configured to explicitly allow SSH access via the `aws_security_group` resource configuration in `main.tf`