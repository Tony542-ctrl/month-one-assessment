#!/bin/bash
# Install PostgreSQL Server
yum update -y
amazon-linux-extras install postgresql14 -y || yum install -y postgresql-server
postgresql-setup initdb || postgresql-setup --initdb
systemctl start postgresql
systemctl enable postgresql

# Modify postgresql.conf to listen on all addresses
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
# Modify pg_hba.conf to allow connections from the VPC network
echo "host    all             all             10.0.0.0/16             md5" >> /var/lib/pgsql/data/pg_hba.conf
systemctl restart postgresql

# Enable password authentication for SSH
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Set a default password for the ec2-user to allow password-based SSH
echo "ec2-user:TechCorp123!" | chpasswd
