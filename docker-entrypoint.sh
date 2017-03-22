#!/bin/bash
set -e

gogs_dir="/home/git/gogs/"
custom_dir="/app/gogs/"

echo "***** Create custom directories *****"
mkdir -p /app/gogs-repositories ${custom_dir}log ${custom_dir}data ${custom_dir}custom/conf

echo "***** Link ${custom_dir} to ${gogs_dir} *****"
ln -snf ${custom_dir}data/ ${gogs_dir}
ln -snf ${custom_dir}custom/ ${gogs_dir}
ln -snf ${custom_dir}log/ ${gogs_dir}
echo "***** Link Ok *****"

echo "***** Set permissions *****"
chmod -R 777 ${gogs_dir}custom ${gogs_dir}log ${gogs_dir}data ${custom_dir}custom ${custom_dir}log ${custom_dir}data
chown -R git:git /home/git/gogs
chown -R git:git /app

echo "***** Done *****"

exec "$@"