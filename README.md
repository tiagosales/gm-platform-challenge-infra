# gm-platform-challenge-infra

Requirements
--------------------
terraform
ansible
popcorn

Run
--------------------
bash infra_create.sh

Info
-------------------
IMPORTANT: To execute properly, you have to access a private bucket containing all the templates to copy.
After execute script, the access urls for loadbalancer, grafana and jenkins will be showed.
Some terraform errors caused by dependency can occur, execute more than one time to be sure that all the necessary infra was created.
To destroy all the created infra, run: "terraform destroy -var-file=gmilechallege.tfvar" in the terraform/$region folder
The file terraform/us-east-1/gmilechallenge.tfvars needs some real information, please fill it!
The private file used by ansible to access the ec2 instances have to be in ansible folder named as amzn.pem
