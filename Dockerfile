# DOCKER-VERSION 1.0.0

FROM phusion/baseimage

### PHUSION-SPECIFIC

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init", "--enable-insecure-key"]

### MIDAS-SPECIFIC

# Set your system's timezone to UTC

RUN echo "UTC" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Get prerequisite packages

RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make git software-properties-common graphicsmagick

RUN apt-get install -y nodejs npm libpq-dev
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g grunt-cli forever

# install our custom Sails PG adapter
RUN git clone https://github.com/Innovation-Toolkit/sails-postgresql.git /tmp/sails-postgresql
RUN cd /tmp/sails-postgresql; git checkout bytea; npm install; npm link


# ... more building instructions here...


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
