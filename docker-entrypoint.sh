#!/bin/bash
set -e

echo "***** Create custom directories *****"
mkdir -p /app/gogs-repositories /app/gogs/log /app/gogs/ssh /app/gogs/data /app/gogs/conf

gogs_conf="/home/git/gogs/custom/conf/app.ini"
custom_conf="/app/gogs/conf/app.ini"

echo "***** If exist custom config file,Link it to default path and else copy default *****"
if [[ -f ${custom_conf} ]]; then
	ln -sf ${custom_conf} ${gogs_conf}
	echo "***** Link ${custom_conf} to ${gogs_conf} *****"
else
	if [[ -f ${gogs_conf} ]]; then
		cp ${gogs_conf} ${custom_conf}
		ln -sf ${custom_conf} ${gogs_conf}
		echo "***** Copy defautl config file to custom path and link it *****"
	else
		echo "***** First start install, Don't have default app.ini *****"
	fi
fi

chown -R git:git /home/git/gogs
chown -R git:git /app

exec "$@"