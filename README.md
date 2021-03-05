# gm-platform-challenge-infra

Requirements
--------------------
terraform<br>
ansible<br>

Run
--------------------
bash infra_create.sh

Info
-------------------
IMPORTANT: To execute properly, you have to access a private bucket containing all the templates to copy.<br>
After execute script, the access urls for loadbalancer, grafana and jenkins will be showed.<br>
Some terraform errors caused by dependency can occur, execute more than one time to be sure that all the necessary infra was created.<br>
To destroy all the created infra, run: "terraform destroy -var-file=gmilechallege.tfvar" in the terraform/$region folder<br>
The file terraform/us-east-1/gmilechallenge.tfvars needs some real information, please fill it!<br>
The private file used by ansible to access the ec2 instances have to be in ansible folder named as amzn.pem<br>


Infrastructure Flow
-------------------
![image](https://user-images.githubusercontent.com/998731/110172113-6cb45700-7ddb-11eb-9e59-2012155bdc22.png)

CICD Flow
-------------------
![image](https://user-images.githubusercontent.com/998731/110172216-8f467000-7ddb-11eb-8b52-f1b054d71d77.png)
