## Making a GitHub repo

make a new public gitbub repo called `tech-508-sparta-test-app`
create a new folder called [`tech-508-sparta-test-app`](/f/gitStuff/tech508-sparta-test-app)

extract the sparta test app zip file to `tech-508-sparta-test-app`

make `tech-508-sparta-test-app` a git repo with `git init`

add all files to staging with `git add .`

make a commit with `git commit -m "text here"`

on github, copy the commands under push an exisiting rep from the command line

## Create an EC2 instance

on aws launch a new instance with the following settings:

- AMI: Ubuntu 22.04
- security group: 
  - allow ssh
  - allow custom tcp, port 3000
  - allow http
- select ssh keypair
  
## SSH into EC2 instance 

click connect on the ec2 instance 

click on the ssh tab and copy the last command 

on gitbash cd into the .ssh folder with: `cd .ssh`

paste and run the command from aws

## Setting up EC2 Instance 

### First time setup

run `sudo apt update && sudo apt upgrade -y` 

on screen is a [pending kernel update](F:\gitStuff\tech508-sparta-test-app\images\Screenshot_5.png) just press ok 

install nginx with: `sudo apt install ngnix -y`(-y to say yes to any input)

on screen is a [pending kernel update](F:\gitStuff\tech508-sparta-test-app\images\Screenshot_5.png) just press ok 

## cloning github repo to EC2 instance

on the github repo press code select https and copy the url `https://github.com/freeApiKeysHere/sparta-test-app.git` 

on ec2 instance do `git clone https://github.com/freeApiKeysHere/sparta-test-app.git repo` the arg after the url is the folder it will go into

## running the node js app


### Create enironment var

if you want the /posts endpoint to work you need to set an env var called `DB_HOST` set to the IP address of the ec2 system thats running the mongodb. this is done with: `export DB_HOST=mongodb://{YOUR EC2'S PRIVATE IP}:27017/posts`

do `npm install`
then `npm start`

check its working by entering `http://{ec2ipv4address}:3000


# backend setup

stuff here from b4

## Create an EC2 instance

on aws launch a new instance with the following settings:

- AMI: Ubuntu 22.04
- security group: 
  - allow ssh
  - allow custom tcp, port 3000
  - allow http
- select ssh keypair
  
## SSH into EC2 instance 

click connect on the ec2 instance 

click on the ssh tab and copy the last command 

on gitbash cd into the .ssh folder with: `cd .ssh`

paste and run the command from aws

### First time setup

run `sudo apt update && sudo apt upgrade -y` 

on screen is a [pending kernel update](F:\gitStuff\tech508-sparta-test-app\images\Screenshot_5.png) just press ok 

### install mongodb community edition ver 7

[install](https://www.mongodb.com/docs/v7.0/tutorial/install-mongodb-on-ubuntu/) mongodb by following the steps found on their website, make sure its the correct ver. for the correct OS

### change mongodb settings

go into monogodb's config file and chnage the bindIp value, do: `cd /etc` and then `nano mongod.conf` and look for `bindIp` and change it to `0.0.0.0` then save and exit.

### start and enable mongodb

do `sudo systemctl start mongod`
and `sudo systemctl enable mongod`
confirm its running with `sudo systemctl status mongod`

