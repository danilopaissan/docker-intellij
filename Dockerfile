FROM ubuntu:19.04
MAINTAINER Danilo Paissan <danilo.paissan@gmail.com>

#Install Open JDK 8 JDK

RUN apt-get update \
    && apt-get -y install openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

ENV IDEA_JDK /usr/lib/jvm/java-8-openjdk-amd64

ENTRYPOINT ["/opt/idea-IU-192.6603.28/bin/idea.sh"]

USER root

ADD https://download.jetbrains.com/idea/ideaIU-2019.2.2.tar.gz /opt/idea.tar.gz

RUN tar --extract --verbose --directory /opt --file /opt/idea.tar.gz && rm -rf /opt/idea-IU-192.6603.28/jre64 && rm -f /opt/idea.tar.gz

USER powerless
