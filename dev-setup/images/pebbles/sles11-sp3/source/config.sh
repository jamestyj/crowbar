#!/bin/bash

# Functions...
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

# Greeting...
echo "Configure image: [$kiwi_iname]..."

# Activate services
suseActivateDefaultServices
chkconfig ntp  on
chkconfig sshd on

# Setup baseproduct link
suseSetupProduct

# Add missing gpg keys to rpm
suseImportBuildKey

# SuSEconfig
suseConfig

# Miscellaneous
sed -i 's/\(LESS="\)/\1-X /'       /etc/profile
sed -i 's/^#\?UseDNS.*/UseDNS no/' /etc/ssh/sshd_config

# Needed for Guardfile.top
mkdir -p /opt/dell/bin

# Mount tftpboot repos via NFS
mkdir -p /srv/tftpboot/repos/Cloud
mkdir -p /srv/tftpboot/suse-11.3/install

# Rehash SSL certs
c_rehash

# Umount kernel filesystems
baseCleanMount

exit 0
