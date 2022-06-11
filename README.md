## Week 13 - Automated ELK Stack Deployment

## ELK-Stack-Project
**Automated ELK Stack Deployment**
 
The files in this repository were used to configure the network depicted below.

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/Diagram%20Screenshot.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml and config files may be used to install only certain pieces of it, such as Filebeat.

  - [ansible config](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/ansible.cfg)
  - [ansible hosts.yml](https://github.com/melclemens/Bootcamp/blob/10e6b705078d1b289d688c1e1c6cdf64d839af0d/Config-Files/hosts.yml)
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

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

What aspect of security do load balancers protect?
> 
The primary function of a load balancer is to spread web traffic across several servers and to protect the availability of the network. The load balancer was put in front of the VM on our network to:
- keep Azure resources safe inside virtual networks
- keep track of virtual networks, subnets, and NICs' configuration and traffic
- secure vital web applications - block communications from known malicious IP addresses - monitor network traffic
- implement network-based intrusion detection/prevention systems (IDS/IPS) - manage traffic to web applications - reduce network security rule complexity and administrative overhead
- maintain standard network device security setups
- utilise automated techniques to monitor network resource configurations and detect changes - document traffic configuration rules


What is the advantage of a jump box?
- A Jump Box, sometimes known as a "Jump Server," is a network gateway that allows users to access and manage devices in various security zones. A Jump Box serves as a "bridge" between two trusted network zones, allowing users to access them in a regulated manner. The public IP address linked with the VM can be blocked. It improves security by preventing all Azure VMs from being exposed to the public.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic

What does Filebeat watch for?
- Filebeat is a lightweight shipper which monitors and consolidates logs, files, and forwards the to Elasticsearch or Logstash for indexing.

What does Metricbeat record?
- Metricbeat is a server monitoring tool that collects metrics from the operating and services running on the server. It then forwards them to Elasticsearch or Logstash.

The configuration details of each machine may be found below.
 
| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box | Gateway  | 20.53.229.179 ; 10.0.0.4   | Linux            |
| Web-1        |webserver    | 10.0.0.5     | Linux            |
| Web-2        |webserver    | 10.0.0.6     | Linux            |
| ELKServer    |Kibana       | 10.1.0.4     | Linux            |
 

### Access Policies
 
The machines on the internal network are not exposed to the public Internet.
 
Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 20.211.68.86 

Machines within the network can only be accessed by SSH from Jump Box.
 
A summary of the access policies in place can be found in the table below.
 
| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump-Box | Yes                 | 20.211.68.86        |
| Elk Server      | Yes                  |  20.227.166.71:5601        |
| Web 1   | No                  |  10.0.0.4       |
| WEb 2   | No                  |  10.0.0.5        |
| Load Balancer   | Yes                  |  Open        |

 
---


### ELK Configuration
 
Ansible was used to automate the configuration of the ELK server. No configuration was performed manually, which is advantageous because it allows you to quickly set up new computers or update programmes with minimal effort and allows you to scale with ease and removes the opportunity for human error.

What is the main advantage of automating configuration with Ansible?
- Ansible is focusing on bringing a server to a certain state of operation.

The playbook implements the following tasks:
- Installs docker.io
- Increases virtual memory
- Downloads and launches a docker elk container

The following screenshot displays the result of running 'docker ps' after successfully configuring the ELK instance

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/docker%20start.png)



### Target Machines & Beats
This ELK server is configured to monitor the following machines:

- Web-1  | 10.0.0.5
- Web-2  | 10.0.0.6

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
- Copy the Filebeat and Meticbeat yaml configuration files to /etc/ansible/files.
- Update the ansible hosts file to include Web1, Web2, and Elk Server IP addresses.
- Run the playbooks and navitage to http://(Elk-VM public IP):5601/app/kibana to check that the installation worked as expected.

Which file is the playbook? Where do you copy it?
 -  The elk_install.yml is the playbook file
 -  You copy the playbook file to the to the /etc/ansible/roles/elk_install.yml
 
Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?
-   You update the host file to make the Ansible playbook run on a specific machine /etc/ansible/hosts.
-   You need to add on an additional zone called [Elk] and include the IP address (10.0.0.4).

Which URL do you navigate to in order to check that the ELK server is running?
-   http://20.227.166.71:5601/app/kibana

As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.

On the Jump box run the following command to get the playbook: curl https://github.com/melclemens/Bootcamp/blob/main/Config-Files/install-elk.yml > /etc/ansible/roles/elk_install.yml

Edit the hosts file in etc/ansible and update your IP address

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/Elk%2010.1.0.4.png)

To run the playbook: ansible-playbook /etc/ansible/roles/elk.install.yml
![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/ansible-playbook.png)

To check it is working go to http://20.227.166.71:5601/app/kibana
![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Diagrams/Kibana%20working.png)





