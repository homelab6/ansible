FROM almalinux:9.6

RUN dnf install -y sudo && \
    useradd user && \
    usermod -aG wheel user && \
    echo 'user ALL=(ALL:ALL) NOPASSWD: ALL' | tee /etc/sudoers.d/user > /dev/null

USER user
WORKDIR /home/user

RUN sudo dnf upgrade -y --security && \
    sudo dnf install -y epel-release && \
    sudo dnf config-manager --set-enabled crb && \
    sudo dnf install -y tar vim procps htop tree git wget \
                        nc nmap iproute

RUN mkdir .ssh

COPY --chown=user:user config/ssh/config .ssh/config

RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm -f get-pip.py && \
    python3 -m pip -V && \
    sudo dnf install -y ansible \
                        ansible-collection-community-general && \
    python3 -m pip install argcomplete && \
    echo >> .bashrc && \
    echo >> .bashrc && \
    echo ". /mnt/config/ansible/cloud.env" >> .bashrc && \
    echo >> .bashrc && \
    echo "activate-global-python-argcomplete 2>/dev/null" >> .bashrc && \
    echo -n ". ~/.bash_completion" >> .bashrc && \
    ansible --version && \
    ansible-community --version

COPY config/ansible/ansible.cfg /etc/ansible/ansible.cfg
COPY --chown=user:user --chmod=750 script/start.sh .
COPY --chown=user:user --chmod=750 script/reload.sh .

WORKDIR /home/user/ansible/playbook

CMD cd ~ && \
    rmdir ansible/playbook && \
    ./start.sh
