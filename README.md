## Ansible-palybook
### *Ansible-Playbook to install the composer*

- **Step1**-> Install the two different virtual machines consider one as a ansible master machine and install the ansible on the specified machine.
- **Step2**-> In the ansible installed machine add the **inventory.ini** file and mention the host ip,remote user name and  the path of the ssh private key.
- **Step3**-> Chech the ssh connectity using the inventory.ini file using the command **ansible ec2-instance -m ping -i inventory.ini.**

          [ec2]
          ec2-instance ansible_host=3.0.147.240 ansible_port=22 ansible_user=ubuntuansible_ssh_private_key_file=/home/ubuntu/inban.pem

- **Step4**-> To install the copomoser necessary dependency is php and its extensions file need, So in my case i have used ubuntu 22.04 os for that supported Php is 7.4 and 8.1 i configured php7.4

          ---
          - name: Install Composer on Ubuntu 22.04 with PHP 7.4
            hosts: all
            become: yes
            gather_facts: false

            tasks:
              - name: Add Ondřej Surý PPA for PHP
                apt_repository:
                  repo: ppa:ondrej/php
                  state: present

              - name: Update apt package cache
                apt:
                  update_cache: yes

              - name: Install PHP 7.4 and required extensions
                apt:
                  name: "{{ item }}"
                  state: present
                loop:
                  - php7.4
                  - php7.4-cli
                  - php7.4-common
                  - php7.4-json
                  - php7.4-mbstring

- **Step5**-> In some use case already php is installed, so just write the playbook to install the composer latest version.
- **step6**-> Used module is package management, this is to enable you to install any package on a system, but usually these modules can install, upgrade, downgrade, remove, and list packages.
- **Step7**-> In playbook_composer.yml file, just mentioned in the task path to install the composer as mention path.

          ---
          - name: Install Composer version 2.7.7
            hosts: all
            become: yes
            gather_facts: false

            tasks:
    
              - name: Download and install Composer
                shell: |
                  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
                args:
                  creates: /usr/local/bin/composer  # Ensures Composer is only installed if not already present

          
