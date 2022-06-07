## Week 13 - Automated ELK Stack Deployment

![Elk graphic](https://github.com/melclemens/Bootcamp/blob/main/Elk.png)
     
---

## ELK-Stack-Project
**Automated ELK Stack Deployment**
 
The files in this repository were used to configure the network depicted below.

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/Diagram%20Screenshot.png)

These files have been tested and used to generate an automated ELK Stack Deployment on Azure. They can be used to either recreate the entire deployment figured below. Otherwise, select portions of the YAML files may be used to install only certain pieces of it, for example, Filebeat and Metricbeat.

  - [install-elk.yml](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/install-elk.yml)
  - [filebeat-config.yml](https://github.com/melclemens/Bootcamp/blob/70f9c68ec80211660e408669b7151d4995b37609/Config-Files/filebeat-configuration.yml)
  - [filebeat-playbook.yml](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/filebeat-playbook.yml)
  - [metricbeat-config.yml](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/metricbeat-configuration.yml)
  - [metricbeat-playbook.yml](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/metricbeat-playbook.yml)
 
This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build
 
### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.

> What aspect of security do load balancers protect?
> 
The primary function of a load balancer is to spread web traffic across several servers. The load balancer was put in front of the VM on our network to:
- keep Azure resources safe inside virtual networks
- keep track of virtual networks, subnets, and NICs' configuration and traffic
- secure vital web applications - block communications from known malicious IP addresses - monitor network traffic
- implement network-based intrusion detection/prevention systems (IDS/IPS) - manage traffic to web applications - reduce network security rule complexity and administrative overhead
- maintain standard network device security setups
- utilise automated techniques to monitor network resource configurations and detect changes - document traffic configuration rules


> What is the advantage of a jump box?
- A Jump Box, sometimes known as a "Jump Server," is a network gateway that allows users to access and manage devices in various security zones. A Jump Box serves as a "bridge" between two trusted network zones, allowing users to access them in a regulated manner. The public IP address linked with the VM can be blocked. It improves security by preventing all Azure VMs from being exposed to the public.

Integrating an Elastic Stack server allows us to easily monitor the vulnerable VMs for changes to their file systems and system metrics.

> What does Filebeat watch for?
- Filebeat makes things easier by providing a lightweight (low memory footprint) means to transfer and consolidate logs, files, and change watches.

> What does Metricbeat record?
- Metricbeat is a server monitoring tool that collects data from the system and services operating on the server in order to record machine metrics and stats like uptime.

The configuration details of each machine may be found below.
 
| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box-Provisioner | Gateway  | 20.53.229.179 ; 10.0.0.4   | Linux            |
| Web-1        |webserver    | 10.0.0.5     | Linux            |
| Web-2        |webserver    | 10.0.0.6     | Linux            |
| ELKServer    |Kibana       | 20.227.166.71 ; 10.1.0.4     | Linux            |
| RedTeam1lb|Load Balancer| 20.92.209.66| DVWA            |
 

### Access Policies
 
The machines on the internal network are not exposed to the public Internet.
 
Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 20.211.68.86 

Machines within the network can only be accessed by SSH from Jump Box.
 
A summary of the access policies in place can be found in the table below.
 
| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump-Box-Provisioner | Yes                 | 20.211.68.86        |
| Elk-vm      | Yes                  |  20.227.166.71:5601        |
| DVWA 1   | No                  |  10.0.0.4       |
| DVWA 2   | No                  |  10.0.0.5        |


 
---


### ELK Configuration
 
Ansible was used to automate the configuration of the ELK server. No configuration was performed manually, which is advantageous because ansible can be used to quickly set up new computers, update programmes, and setup hundreds of servers at once, and the greatest part is that the method is the same whether we're managing one machine or dozens or hundreds.

> What is the main advantage of automating configuration with Ansible?
- Ansible is focusing on bringing a server to a certain state of operation.

The playbook implements the following tasks:
- Deploying a new VM. 
  -  Creating a new vNet in the same resoure group and using a different region.
  -  Creating a peer connection to allow traffic to pass between our vNets and regions allowing traffice to pass in both directions
  -  Create a new Ubuntu VM in our virtual network 
- Creating an ansible play to install and configure on the ELK instance
  -  Adding our new VM to the Ansible hosts file
  -  Creating a new Ansible playbook to use for the new EK virtual machine
  -  From our Ansible container, adding the new VM to Ansible's hosts file
- Restricting access to the server
  -  Add public IP address to whitelist 


The following screenshot displays the result of running 'docker ps' after successfully configuring the ELK instance

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/docker%20start.png)



### Target Machines & Beats
This ELK server is configured to monitor the following machines:

- Web-1 (DVWA 1) | 10.0.0.5
- Web-2 (DVWA 2) | 10.0.0.6

I have installed the following Beats on these machines:

- Filebeat
- Metricbeat
	
These Beats allow us to collect information from each machine:

`Filebeat`: Changes to the filesystem are detected by Filebeat. I use it to collect system logs and, more precisely, to detect failed sudo escalations and SSH login attempts.
	
`Metricbeat`: Metricbeat detects changes in system metrics, such as CPU usage and memory usage.

---
 
### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the elk_install.yml file to /etc/ansibe/roles/elk_install.yml
- Update the hosts file to include  the attribute elk, then destination ip of the ELK server.
- Run the playbook, and navigate to http://20.227.166.71:5601/app/kibana to check that the installation worked as expected.

___TODO: Answer the following questions to fill in the blanks:_
_-  Which file is the playbook? Where do you copy it?
 -  The elk_install.yml is the playbook file
 -  You copy the playbook file to the to the /etc/ansible/roles/elk_install.yml
 
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?
-   You update the host file to make the Ansible playbook run on a specific machine.
-   You specify ???

- _Which URL do you navigate to in order to check that the ELK server is running?_
  http://20.227.166.71:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.______

On the Jump box run the following command to get the playbook: curl https://github.com/melclemens/Bootcamp/blob/main/Config-Files/install-elk.yml > /etc/ansible/roles/elk_install.yml

Edit the hosts file in etc/ansible and update your IP address

To run the playbook: ansible-playbook /etc/ansible/roles/elk.install.yml
![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Screenshot%202022-06-06%20231914.png)

To check it is working go to http://20.227.166.71:5601/app/kibana





