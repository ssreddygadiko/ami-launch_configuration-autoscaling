#!/bin/bash
#Json config file path
if [ -f /etc/redhat-release ]; then
	config="$(find /root/ -iname ami-config.json)"
elif [ -f /etc/lsb-release ]; then
  	config="$(find /home/ -iname ami-config.json)"
fi

#Passing the parameters by using json file.
DATE=$(date +%Y-%m-%d_%H-%M)
instance_id=$(jq -r '.instance.instance_id' $config)
Region=$(jq -r '.instance.Region' $config)
AMI_name=$(jq -r '.AMI.AMI_name' $config)
AMI_des=$(jq -r '.AMI.AMI_des' $config)
instance_type=$(jq -r '.Launch_configuration.instance_type' $config)
ASG_name=$(jq -r '.Launch_configuration.ASG_name' $config)
New_LC=$(jq -r '.Launch_configuration.New_LC' $config)
key_pair=$(jq -r '.Launch_configuration.keypair' $config)
SG_id=$(jq -r '.Launch_configuration.SG_id' $config)

#Create AMI
IMAGE=`aws ec2 create-image --region "$Region" --instance-id "$instance_id" --name "$AMI_name-$DATE" --description "$AMI_des-$DATE" --no-reboot --output text`

# Create Launch Configuration
aws autoscaling create-launch-configuration --region "$Region" --launch-configuration-name "$New_LC-$DATE" --image-id "$IMAGE" --instance-type "$instance_type" --key-name "$key_pair" --security-groups "$SG_id"

# Update Auto Scaling Group to use new Launch Configuration
aws autoscaling update-auto-scaling-group --region "$Region" --auto-scaling-group-name "$ASG_name" --launch-configuration-name "$New_LC-$DATE"
