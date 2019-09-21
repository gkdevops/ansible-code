#!/bin/bash

cd /opt/
curl -O https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.7.9-1.el7.ans.noarch.rpm
yum repolist
yum-config-manager --enable rhui-REGION-rhel-server-extras >/dev/null
yum repolist
yum install ansible-2.7.9-1.el7.ans.noarch.rpm -y
ansible --version
