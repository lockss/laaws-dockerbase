FROM lockss/laaws-base

MAINTAINER "Daniel Vargas" <dlvargas@stanford.edu>

# Get laaws-mdx source 
RUN git clone https://github.com/lockss/laaws-mdx.git --recursive

# Build LOCKSS daemon JARs
#WORKDIR /laaws-mdx
#RUN ./initBuild

# XXX Isolate only what's needed to run
#RUN mkdir /laaws-mdx
#RUN mv target /laaws-mdx
#RUN mv runLaawsmdx /laaws-mdx
#RUN mv src /laaws-mdx

# XXX Clean up 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#RUN rm -rf ~/.m2 ~/.subversion

# XXX Ask fergaloy to fix
RUN mkdir logs
RUN touch logs/laawsmdx.log

# XXX Overlay needed for demo
ADD lockss.opt /laaws-mdx

CMD ["/bin/sh", "/laaws-mdx/runLaawsMdx"]
