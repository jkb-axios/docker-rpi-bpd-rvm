# Pull base image
FROM kipp/rpi-buildpack-deps:v2
MAINTAINER Kipp Bowen <kipp.bowen@axiosengineering.com>

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN source /usr/local/rvm/scripts/rvm
RUN /bin/bash -l -c "rvm install 1.9.3"
#. /etc/profile
#. /etc/profile.d/rvm.sh
#/usr/local/rvm/bin/rvm

RUN gem update \
    && gem install rubygems-update \
            bundler \
            json \
            awscli
#RUN /bin/bash -l -c "gem install rubygems-update bundler json awscli"

# pull soca git repo and apply patch, build, install
RUN mkdir -p /data/repos \
    && cd /data/repos \
    && git clone https://github.com/quirkey/soca.git soca \
    && cd /data/repos/soca \
    && git checkout v0.3.3
ADD ./fix_file_read.patch2 /data/repos/soca/fix_file_read.patch2
RUN cd /data/repos/soca && patch -p1 < fix_file_read.patch2
RUN cd /data/repos/soca && gem build soca.gemspec
RUN cd /data/repos/soca && gem install soca-*.gem

