FROM haproxy

ADD sources.list /etc/apt/

# Install rsyslog
RUN apt-get update && \
  apt-get install -y rsyslog keepalived net-tools iputils-ping && \
  rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
