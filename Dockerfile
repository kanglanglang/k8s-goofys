FROM alpine:latest

RUN apk add --no-cache --virtual=build-dependencies go git musl-dev \
	&& GOPATH=/tmp/go \
	&& export GOPATH=$GOPATH \
	&& go get github.com/kahing/goofys \
	&& go install github.com/kahing/goofys \
	&& cp $GOPATH/bin/goofys /usr/local/bin \
	&& \
	apk add --no-cache ca-certificates fuse syslog-ng \
	&& \
	echo '@version: 3.19' > /etc/syslog-ng/syslog-ng.conf \
	&& echo 'source goofys {internal();network(transport("udp"));unix-dgram("/dev/log");};' >> /etc/syslog-ng/syslog-ng.conf \
	&& echo 'destination goofys {file("/var/log/goofys");};' >> /etc/syslog-ng/syslog-ng.conf \
	&& echo 'log {source(goofys);destination(goofys);};' >> /etc/syslog-ng/syslog-ng.conf \
	&& \
	apk del build-dependencies go git musl-dev \
	&& rm -rf /tmp/*

ENV MOUNT_DIR /data
ENV REGION us-east-1
ENV BUCKET bucket
ENV STAT_CACHE_TTL 1m0s
ENV TYPE_CACHE_TTL 1m0s
ENV DIR_MODE 0700
ENV FILE_MODE 0600

RUN mkdir -p /data
VOLUME /data

ADD entrypoint.sh /

ENTRYPOINT ["sh"]
CMD ["/entrypoint.sh"]
