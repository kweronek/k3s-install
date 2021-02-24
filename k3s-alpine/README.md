# K8S-Cluster based on AWS-EC2, Alpine and K3S

## Launch AWS-EC2-Instances with Alpine
### Alpine-AMI
Alpine Linux 3.12.0 (Oct.2020):
AMI: alpine-ami-edge-x86_64-20200425232123 (ami-097be5ea1a5c7b6ce)

### AWS-EC2-Instance
#### Minimum Hardware Requirements
Master: RAM   1GB, 1vCPU --> t2.micro, t3.micro, t3a.micro  
Worker: RAM 500MB, 1vCPU --> t2.nano,  t3.nano,  t3a.nano  

#### Recommended Hardware Requirements
Master: RAM   4GB, 2vCPU --> t2.medium, t3.medium, t3a.medium (up to 10 nodes)  
Worker: RAM   2GB, 2vCPU --> t3.small, t3a.small  

#### Disks
Master: Disk minimum 1GB, recommended 2GB or more,   
Worker: Disk minimum 1GB, recommended 2GB or more.  

#### Tags (recommended)
Master:  
"Name" : "Clustername-Master-##"  
"AMI"  : "Alpine Linux 3.12.0"  
Worker:  
"Name" : "Clustername-Worker-##"  
"AMI"  : "Alpine Linux 3.12.0"  

#### Security-Groups
For test purposes add the following Inbound-Rule:  
"allow port 0-65353 from any IP".  
For production use the following inbound rules:  
Server:   
tbd  

Worker:  
tbd  

## Configuration of K8s-Nodes  
### Booststrapping of Alpine Nodes
```
wget https://raw.githubusercontent.com/kweronek/k3s-alpine/main/setup-node && chmod 744 * && sudo ./setup-node
```
#### Provisioning of K3s-server
To provision the K3s-server use the script provided by Rancher like this:
```
sudo curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable-agent --write-kubeconfig-mode 644" sh -  
```
Please note that "--write-kubeconfig-mode 644" reduces the security for test reasons. In production this expression must be removed.

To print out the node token use:
```
sudo cat /var/lib/rancher/k3s/server/node-token
```
#### Provisioning of K3s-worker
To provision the K3s-worker nodes use the script provided by Rancher.
You have to replace the value of the K3S_TOKEN by the actual node-token of the server. The value of the K3S_URL needs to be replaced by the actual public URL of the server of the master node which can be achieved using the AWS console.
```
sudo curl -sfL https://get.k3s.io | K3S_URL=https://ec2-XX-XX-XX-XX.compute-1.amazonaws.com:6443 K3S_TOKEN=K10d....46b9 sh -
```

## Test the Cluster
