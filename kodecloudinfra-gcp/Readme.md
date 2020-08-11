Prereqesites :

Create a GCP free tier account.

https://cloud.google.com/free

Install Gcloud SDK , it will be helpful for running gcloud commands.

https://cloud.google.com/sdk/docs/downloads-versioned-archives

Install terrafrom 

https://learn.hashicorp.com/tutorials/terraform/install-cli

Download the Terraform file. 

Make sure you are keeping the json key in particular path.

RUN  ' terraform init ' to download the provider plugin. Here it is Google. 

RUN  ' terraform plan ' it will show how resources will be created. 

RUN  ' terraform validate' just to verify configuration file is proper or not. 

RUN  ' terraform apply '. it will create the resources once you agree with the prompt with ' yes'. 

Go to IAM create a service account and generate the json key.

Create a terraform file consists of Network , subnet , firewall , and GCP instances.

This terraform file mentioned in the git will  create 3 servers 1 master , 2 slaves in  2 mins 


