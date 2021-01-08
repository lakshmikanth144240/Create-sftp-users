#!/bin/bash
#this is for name 
echo "hey myaan what is your name?"
read PERSON

#this will create a user
sudo adduser $PERSON

echo "what is the DIRECTORY name?"
read  DIRECTORY

#this will create a directory
sudo mkdir -p /var/sftp/$DIRECTORY

#set owner to root
sudo chown root:root /var/sftp

#add permissions to the user, group and others
sudo chmod 755 /var/sftp

#this will change ownership of dir to the user
sudo chown $PERSON:$PERSON /var/sftp/$DIRECTORY

#this will  allow access to user and deny groups and others
sudo chmod  700 /var/sftp/$DIRECTORY

sudo cat >> /etc/ssh/sshd_config <<EOL

Match User $PERSON
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /var/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no

EOL

#restart the service
sudo systemctl restart sshd 



