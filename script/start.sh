#!/usr/bin/env bash

sudo mkdir /mnt/secrets
sudo cp secrets/* /mnt/secrets/
sudo chown user:user /mnt/secrets/*

git clone git@github.com:homelab6/ansible.git

sudo mkdir -p /mnt/config/ansible
sudo chown user:user /mnt/config/ansible

git config --global user.email "developer@homelab6.com"
git config --global user.name "Developer Homelab6"

git clone --single-branch --branch develop-config git@github.com:homelab6/ansible.git /mnt/config/ansible/

rm -rf /mnt/config/ansible/.git

sudo find /mnt/config/ -type f -exec chmod 640 {} \;

cat /mnt/config/ansible/etc-hosts | sudo tee -a /etc/hosts > /dev/null


tail -f /dev/null
