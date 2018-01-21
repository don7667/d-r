FROM ubuntu:trusty

RUN \
    # Install Java 8
    sed -i.bak 's/main$/main universe/' /etc/apt/sources.list \
    && apt-get update -qq && apt-get install -y software-properties-common curl \
    && add-apt-repository ppa:webupd8team/java -y \
    && apt-get update -qq \
    && apt-get install -y wget unzip \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y oracle-java8-installer || true \
    && cd /var/lib/dpkg/info \
    && sed -i 's|JAVA_VERSION=8u151|JAVA_VERSION=8u162|' oracle-java8-installer.* \
    && sed -i 's|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/|' oracle-java8-installer.* \
    && sed -i 's|SHA256SUM_TGZ="c78200ce409367b296ec39be4427f020e2c585470c4eed01021feada576f027f"|SHA256SUM_TGZ="68ec82d47fd9c2b8eb84225b6db398a72008285fafc98631b1ff8d2229680257"|' oracle-java8-installer.* \
    && sed -i 's|J_DIR=jdk1.8.0_151|J_DIR=jdk1.8.0_162|' oracle-java8-installer.* \
    && apt-get install -y oracle-java8-installer \
    && apt-get install -y oracle-java8-set-default \

    # Install Riak
    && curl -fsSL "https://packagecloud.io/install/repositories/basho/riak/script.deb" > /tmp/riak_setup.sh \
    && chmod +x /tmp/riak_setup.sh && /tmp/riak_setup.sh \
    && apt-get install -y supervisor riak=2.0.5-1 \

    # Cleanup
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US en_US.UTF-8

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entrypoint.sh /
COPY ./ssl-cert /etc/riak

CMD ["/entrypoint.sh"]
