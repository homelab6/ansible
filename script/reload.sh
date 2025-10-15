#!/usr/bin/env bash

rm -rf /mnt/config/ansible/*

git clone --single-branch --branch develop-config git@gitlab.com:cloud4583526/ansible.git /mnt/config/ansible/

rm -rf /mnt/config/ansible/.git

sudo find /mnt/config/ -type f -exec chmod 640 {} \;

sed -n '/### etc-hosts ###/q;p' /etc/hosts | sed '$d' | sudo tee /etc/hosts > /dev/null

cat /mnt/config/ansible/etc-hosts | sudo tee -a /etc/hosts > /dev/null
