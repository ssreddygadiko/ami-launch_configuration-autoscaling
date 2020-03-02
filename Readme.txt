#Pre requirements to exit the script

1. Configure the aws-cli in your machine where you are going to execute the ami script.
#If os is ubuntu means run the below commands.
sudo apt-get update
sudo apt-get install awscli -y
sudo aws configure
Then give inputs like access key and secret key

#If os is Redhat or Amazon-linux means run the below commands.
sudo yum update
sudo yum install awscli -y
sudo aws configure
Then give inputs like access key and secret key

2. Configure jq in your machine to run the json files.
#If os is ubuntu means run the below commands.
sudo apt-get install jq -y

#If os is Redhat or Amazon-linux means run the below commands.
sudo yum install epel-release -y
sudo yum install jq -y

