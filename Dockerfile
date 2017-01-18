FROM ubuntu:latest

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

# Set LANG (needed for msginit -- called by lockss-daemon build.xml)
ENV LANG en_US.UTF-8
RUN locale-gen ${LANG}

# Install build tools
RUN apt-get update
RUN apt-get -y install git subversion ant gettext openjdk-8-jdk-headless maven

# Add our custom POMs
ADD poms /poms

# Build and install LOCKSS JARs into local Maven repository
ADD setupEnv.sh /
RUN chmod +x /setupEnv.sh
RUN /setupEnv.sh

# Pull Maven dependencies 
RUN wget https://raw.githubusercontent.com/lockss/laaws-mdq/master/pom.xml
RUN mvn install
