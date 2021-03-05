#!/bin/bash
export ANSIBLE_HOST_KEY_CHECKING="False"
OLDPWD=$PWD
cd terraform/us-east-1
terraform plan --var-file gmilechallenge.tfvars
terraform apply --var-file gmilechallenge.tfvars
if [ $? -eq 0 ]; then
  terraform output > ../../tfips
else
  "Error executing terraform apply, check! Sometimes rerun helps."
  exit 1
fi


cd $OLDPWD
JENKINSSERVER=$(grep jenkins-server tfips | awk -F= {'print $2'} | awk {'print $1'} | tr -d \")
MONITORSERVER=$(grep monitoring-server tfips | awk -F= {'print $2'} | awk {'print $1'} | tr -d \")
LBACCESS=$(grep app-access tfips | awk -F= {'print $2'} | tr -d \")

cd ansible

sed -e "s/%JENKINSSERVER%/$JENKINSSERVER/g" -e "s/%MONITORSERVER%/$MONITORSERVER/g" hosts.template > hosts 
ansible-playbook -i hosts jenkins-server.yaml
ansible-playbook -i hosts monitoring-server.yaml

echo "Jenkins Access: ${JENKINSSERVER}:8080"
echo "Grafana Access: ${MONITORSERVER}:3000"
echo "App Access: $LBACCESS"

cd $OLDPWD
