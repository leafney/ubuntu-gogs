FROM ubuntu:16.04
MAINTAINER leafney "babycoolzx@126.com"

RUN apt-get update
RUN apt-get install -y git wget openssh-server && \
    groupadd git && useradd -d /home/git -m -g git git

ENV GOGS_VERSION 0.10.18

RUN set -x && \
    cd /tmp && \
    wget --no-check-certificate https://github.com/gogits/gogs/releases/download/v${GOGS_VERSION}/linux_amd64.tar.gz -O gogs.tar.gz && \
    tar -C /home/git -xzf gogs.tar.gz && \
    rm gogs.tar.gz && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Setting timezone for China
RUN ln -sf /usr/share/zoneinfo/Asia/ShangHai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

# use gosu to run git user
RUN set -x && \
	wget --no-check-certificate -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 && \
	chmod +x /usr/local/bin/gosu

COPY ./run.sh /usr/local/bin/
RUN chmod +x usr/local/bin/run.sh
COPY ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# must set run directory to /home/git/gogs
WORKDIR /home/git/gogs
VOLUME ["/app"]

EXPOSE 22 3000

CMD ["run.sh"]