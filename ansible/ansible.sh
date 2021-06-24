#!/bin/bash
sudo python -m pip install ansible
ansible-galaxy init jenkins
ansible-galaxy collection install google.cloud
ansible-playbook setup.yml -i ip.txt
export JENKINSPASSW="$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"

