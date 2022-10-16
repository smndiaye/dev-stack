FROM ubuntu:22.10

# ubuntu setup: install necessary packages
RUN apt update && \
    apt -y upgrade && \
    apt -y dist-upgrade && \
    apt install -y init && \
    apt install -y systemd && \
    apt install -y sudo locales git lsb-release iproute2 && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

WORKDIR /opt

# download devstack
RUN git clone https://opendev.org/openstack/devstack

# copy stack conf
COPY conf/local.conf /opt/devstack/

# configure stack user
RUN ./devstack/tools/create-stack-user.sh
