FROM openjdk:8-alpine

MAINTAINER Danilo Paissan <danilo.paissan@gmail.com>

ENV IDEA_JDK /usr/lib/jvm/zulu-8-amd64

ENTRYPOINT ["/opt/idea-IU-192.6603.28/bin/idea.sh"]

USER root

ADD https://download.jetbrains.com/idea/ideaIU-2019.2.2.tar.gz /opt/idea.tar.gz

RUN tar --extract --verbose --directory /opt --file /opt/idea.tar.gz && rm -rf /opt/idea-IU-192.6603.28/jre64 && rm -f /opt/idea.tar.gz

USER powerless
