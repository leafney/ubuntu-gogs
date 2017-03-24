#!/bin/bash
set -e

gogs_dir="/home/git/gogs/"
custom_dir="/app/gogs/"

echo "***** To create .ssh directory *****"
if [[ ! -d "/home/git/.ssh" ]]; then
	mkdir -p /home/git/.ssh
	echo "***** Create .ssh dir *****"
fi

if [[ ! -f "/home/git/.ssh/authorized_keys" ]]; then
	touch /home/git/.ssh/authorized_keys
	echo "***** Create authorized_keys file *****"
fi

chmod 0700 /home/git/.ssh
chmod 0600 /home/git/.ssh/*


echo "***** To start ssh service *****"
service ssh stop
service ssh start

var=$(service ssh status)
echo "***** The SSH service status is : *****"
echo $var


echo "***** To create custom directories *****"
mkdir -p /app/gogs-repositories ${custom_dir}log ${custom_dir}data ${custom_dir}custom/conf

echo "***** Link ${custom_dir} to ${gogs_dir} *****"
ln -snf ${custom_dir}data/ ${gogs_dir}
ln -snf ${custom_dir}custom/ ${gogs_dir}
ln -snf ${custom_dir}log/ ${gogs_dir}
echo "***** Link Ok *****"

echo "***** Set permissions *****"
chmod -R 777 ${gogs_dir}custom ${gogs_dir}log ${gogs_dir}data ${custom_dir}custom ${custom_dir}log ${custom_dir}data
chown -R git:git /home/git
chown -R git:git /app

echo "***** Done *****"

exec "$@"