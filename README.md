# Ansible-palybook
Ansible-Playbook to inatall the composer 

- Step1-> Install the two different virtual machines consider one as a ansible master machine and install the ansible on the specified machine.
- Step2-> In the ansible installed machine add the **inventory.ini** file and mention the host ip,remote user name and mention the path of the ssh private key.
- Step3-> Chech the ssh connectity using the inventory.ini file using the command **ansible ec2-instance -m ping -i inventory.ini**
- Step4-> 
