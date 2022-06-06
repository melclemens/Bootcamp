Week 13 Automated Elk Stack Deployment

Bootcamp Activities
!(https://github.com/melclemens/Bootcamp/blob/main/Elk.png)

     
<img align="center" width="5600" height="530" src="						   
Elk.png
---

## ELK-Stack-Project
**Automated ELK Stack Deployment**
 
The files in this repository were used to configure the network depicted below.

![vNet Diagram](https://github.com/melclemens/Bootcamp/blob/main/Screenshot%202022-06-06%20231914.png)

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
- The primary function of a load balancer is to spread web traffic across several servers. The load balancer was put in front of the VM on our network to
- keep Azure resources safe inside virtual networks
- keep track of virtual networks, subnets, and NICs' configuration and traffic.
- secure vital web applications - block communications from known malicious IP addresses - monitor network traffic
- implement network-based intrusion detection/prevention systems (IDS/IPS) - manage traffic to web applications - reduce network security rule complexity and administrative overhead
- Maintain standard network device security setups
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
 
Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 47.185.204.83 

Machines within the network can only be accessed by SSH from Jump Box.
 
A summary of the access policies in place can be found in the table below.
 
| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump-Box-Provisioner | Yes                 | 47.185.204.83        |
| ELKServer      | Yes                  |  47.185.204.83:5601        |
| DVWA 1   | No                  |  10.0.0.1-254        |
| DVWA 2   | No                  |  10.0.0.1-254        |


 
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
****how do i past the image in?? ****************
 

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

- Web-1 (DVWA 1) | 10.0.0.5
- Web-2 (DVWA 2) | 10.0.0.6

I have installed the following Beats on these machines:

- Filebeat
- Metricbeat

<details>
<summary> <b> Click here to view Target Machines & Beats. </b> </summary>

---

	
These Beats allow us to collect the following information from each machine:

`Filebeat`: Filebeat detects changes to the filesystem. I use it to collect system logs and more specifically, I use it to detect SSH login attempts and failed sudo escalations.

We will create a [filebeat-config.yml](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Ansible/filebeat-config.yml) and [metricbeat-config.yml](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Ansible/metricbeat-config.yml) configuration files, after which we will create the Ansible playbook files for both of them.

Once we have this file on our Ansible container, edit it as specified:
- The username is elastic and the password is changeme.
- Scroll to line #1106 and replace the IP address with the IP address of our ELK machine.
output.elasticsearch:
hosts: ["10.1.0.4:9200"]
username: "elastic"
password: "changeme"
- Scroll to line #1806 and replace the IP address with the IP address of our ELK machine.
	setup.kibana:
host: "10.1.0.4:5601"
- Save both files filebeat-config.yml and metricbeat-config.yml into `/etc/ansible/files/`

![files_FMconfig](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/files_FMconfig.png) 
 
 
Next, create a new playbook that installs Filebeat & Metricbeat, and then create a playbook file, `filebeat-playbook.yml` & `metricbeat-playbook.yml`

RUN `nano filebeat-playbook.yml` to enable the filebeat service on boot by Filebeat playbook template below:

```yaml
---
- name: Install and Launch Filebeat
  hosts: webservers
  become: yes
  tasks:
    # Use command module
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb
    # Use command module
  - name: Install filebeat .deb
    command: dpkg -i filebeat-7.4.0-amd64.deb
    # Use copy module
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/roles/install-filebeat/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml
    # Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system
    # Use command module
  - name: Setup filebeat
    command: filebeat setup
    # Use command module
  - name: Start filebeat service
    command: service filebeat start
    # Use systemd module
  - name: Enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes

```

![Filebeat_playbook](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Filebeat_playbook.png) 
 
- RUN `ansible-playbook filebeat-playbook.yml`

![Filebeat_playbook_result](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Filebeat_playbook_result.png)  

Verify that our playbook is completed by navigate back to the Filebeat installation page on the ELK server GUI

![Filebeat_playbook_verify](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Filebeat_playbook_verify.png)
	
![Filebeat_playbook_verify1](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Filebeat_playbook_verify1.png)
		
	
`Metricbeat`: Metricbeat detects changes in system metrics, such as CPU usage and memory usage.

RUN `nano metricbeat-playbook.yml` to enable the metricbeat service on boot by Metricbeat playbook template below:

```yaml
---
- name: Install and Launch Metricbeat
  hosts: webservers
  become: true
  tasks:
    # Use command module
  - name: Download metricbeat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.4.0-amd64.deb
    # Use command module
  - name: install metricbeat
    command: dpkg -i metricbeat-7.4.0-amd64.deb
    # Use copy module
  - name: drop in metricbeat config
    copy:
      src: /etc/ansible/roles/install-metricbeat/files/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml
    # Use command module
  - name: enable and configure docker module for metric beat
    command: metricbeat modules enable docker
    # Use command module
  - name: setup metric beat
    command: metricbeat setup
    # Use command module
  - name: start metric beat
    command: service metricbeat start
    # Use systemd module
  - name: Enable service metricbeat on boot
    systemd:
      name: metricbeat
      enabled: yes
```

![Metricbeat_playbook](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Metricbeat_playbook.png)  
 
- RUN `ansible-playbook metricbeat-playbook.yml`

![Metricbeat_playbook_result](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Metricbeat_playbook_result.png)  

Verify that this playbook is completed by navigate back to the Filebeat installation page on the ELK server GUI

![Metricbeat_playbook_verify](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/Metricbeat_playbook_verify.png)

 
</details>

---
 
### Using the Playbook

Next, I want to verify that `filebeat` and `metricbeat` are actually collecting the data they are supposed to and that my deployment is fully functioning.

To do so, I have implemented 3 tasks:

1. Generate a high amount of failed SSH login attempts and verify that Kibana is picking up this activity.
2. Generate a high amount of CPU usage on my web servers and verify that Kibana picks up this data.
3. Generate a high amount of web requests to my web servers and make sure that Kibana is picking them up.
	
<details>
<summary> <b> Click here to view Using the Playbook. </b> </summary>

---


#### Generating a high amount of failed SSH login attempts:

To generate these attempts I intentionally tried to connect to my Web-1 web server from the Jump Box instead of connecting from my Ansible container in order to generate failed attempts (the server can't verify my private key outside of the container). All ELK Stack scripts refer to [Elk_Stack_scripts.sh](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Linux/Elk_Stack_scripts.sh)

To do so I used the following short script to automate 1000 failed SSH login attempts: 


```bash
for i in {1..1000}; do ssh Web_1@10.0.0.5; done
```

![ssh failed attempts](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/ssh%20failed%20attempts.png)


Next We check Kibana to see if the failed attempts were logged:


![filebeat failed ssh attempts](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/filebeat%20failed%20ssh%20attempts.png)

I can see that all the failed attempts were detected and sent to Kibana.

- Now Let's breakdown the syntax of my previous short script:

   - `for` begins the `for` loop.

   - `i in` creates a variable named `i` that will hold each number `in` our list.

   - `{1..1000}` creates a list of 1000 numbers, each of which will be given to our `i` variable.

   - `;` separates the portions of our `for` loop when written on one line.

   - `do` indicates the action taken by each loop.

   - `ssh sysadmin@10.0.0.5` is the command run by `do`.

   - `;` separates the portions of our for loop when it's written on one line.

   - `done` closes the `for` loop.

- Now I can run the same short script command with a few modifications, to test that `filebeat` is logging all failed attempts on all web servers where `filebeat` was deployed.

I want to run a command that will attempt to SSH into multiple web servers at the same time and continue forever until I stop it:

```bash
while true; do for i in {5..6}; do ssh Web_1@10.0.0.$i; done
```

- Now let's breakdown the syntax of my previous short script:

   - `while` begins the `while` loop.

   - `true` will always be equal to `true` so this loop will never stop, unless we force quit it.

   - `;` separates the portions of our `while` loop when it's written on one line.

   - `do` indicates the action taken by each loop.

   - `i in` creates a variable named `i` that will hold each number in our list.

   - `{5..6}` creates a list of numbers (5 and 6), each of which will be given to our `i` variable.

   - `ssh sysadmin@10.0.0.$i` is the command run by `do`. It is passing in the `$i` variable so the `wget` command will be run on each server, i.e., 10.0.0.5, 10.0.0.6 (Web-1, Web-2).


Next, I want to confirm that `metricbeat` is functioning. To do so I will run a linux stress test.


#### Generating a high amount of CPU usage on my web servers (Web-1, Web-2) and confirming that Kibana is collecting the data.


1. From my Jump Box, I start my Ansible container with the following command:

```bash
sudo docker start goofy_wright && sudo docker attach goofy_wright
```

2. Then, SSH from my Ansible container to Web-1.

```bash
ssh sysadmin@10.0.0.5
```

3. Install the `stress` module with the following command:

```bash
sudo apt install stress
```

4. Run the service with the following command and let the stress test run for a few minutes:

```bash
sudo stress --cpu 1
```

   - _Note: The stress program will run until we quit with Ctrl+C._
	
Next, view the Metrics page for that VM in Kibana and comparing 2 of web servers to see the differences in CPU usage, confirmed that `metricbeat` is capturing the increase in CPU usage due to our stress command:

![cpu stress test results](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/cpu%20stress%20test%20results.png)


Another view of the CPU usage metrics Kibana collected:

![cpu stress test results graph](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/cpu%20stress%20test%20results%20graph.png)


#### Generate a high amount of web requests to both web servers and make sure that Kibana is picking them up.

This time we will generate a high amount of web requests directed to one of my web servers. To do so, I will use `wget` to launch a DoS attack.

1. Log into my Jump Box Provisioner
	
   - ```bash
        ssh sysadmin@<jump-box-provisioner>
     ``` 

2. We need to add a new firewall rule to allow my Jump Box (10.0.0.4) to connect to my web servers over HTTP on port 80. To do so, I add a new Inbound Security Rule to Red-Team Network Security Group:

![jump to http to webservers](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/jump%20to%20http%20to%20webservers.png)


3. Run the following command to download the file `index.html` from Web-1 VM:

   - ```bash
        wget 10.0.0.5
     ```

Output of the command:

![index html download](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/index%20html%20download.png)


4. Confirm that the file has been downloaded with the `ls` command:


   - ```bash
        sysadmin@Jump-Box-Provisioner:~$ ls 
        index.html
     ```

5. Next, run the `wget` command in a loop to generate a very high number of web requests, I will use the `while` loop:

   - ```bash
        while true; do wget 10.0.0.5; done
     ```

The result is that the `Load`, `Memory Usage` and `Network Traffic` were hit as seen below:

![load increase DoS](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/load%20increase%20DoS.png)

After stopping the `wget` command, I can see that thousands of index.html files were created (as seen below).


![index html files](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/index%20html%20files.png)


I can use the following command to clean that up:

```bash
rm *
```

Now if we use `ls` again, the directory is a lot cleaner:


![directory cleanup](https://github.com/Diablo5G/ELK-Stack-Project/blob/main/Resources/Images/directory%20cleanup.png)


I can also avoid the creation of the `index.html` file by adding the flag `-O` to my command so that I can specify a destination file where all the `index.html` files will be concatenated and written to.

Since I don't want to save the `index.html` files, I will not write them to any output file but instead send them directly to a directory that doesn't save anything, i.e., `/dev/null`. 

I use the following command to do that:


```bash
while true; do wget 10.0.0.5 -O /dev/null; done
```

Now, if I want to perform the `wget` DoS request on all my web servers, I can use the previous command I used to generate failed SSH login attempts on all my web servers, but this time I will tweak the command to send `wget` requests to all webservers:

```bash
while true; do for i in {5..6}; do wget -O /dev/null 10.0.0.$i; done
```

Note that we need to press CTRL + C to stop the `wget` requests since I am using the `while` loop.



### Citations and References:

#### General Resources:

- [`elk-docker` Container Documentation](https://elk-docker.readthedocs.io/)
- [Elastic.co: The Elastic Stack](https://www.elastic.co/elastic-stack)
- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [`elk-docker` Image Documentation](https://elk-docker.readthedocs.io/#elasticsearch-logstash-kibana-elk-docker-image-documentation)
- [Virtual Memory Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count)
- [Docker Commands Cheatsheet](https://phoenixnap.com/kb/list-of-docker-commands-cheat-sheet)

#### Azure Documentation:

- Azure's page on peer networks: [Network-Peering](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)
- Peer networking in Azure How-To: [Global vNet Peering](https://azure.microsoft.com/en-ca/blog/global-vnet-peering-now-generally-available/)
- Microsoft Support: [How to open a support ticket](https://docs.microsoft.com/en-us/azure/azure-portal/supportability/how-to-create-azure-support-request)

---

#### Special thanks:

© Trilogy Education Services, a 2U, Inc., Instructor Jerry Arnold and TAs; Matt McNew, Jansen Russell, Micheal Stephenson.

© The University of Texas at Austin Boot Camp, The Cybersecurity program.

---
