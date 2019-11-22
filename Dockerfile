FROM golang as build
WORKDIR /work
RUN git clone https://github.com/micromdm/micromdm.git \
    && cd micromdm \
    && make build \
    && ls -al /work/micromdm/build/linux

#  output an image which includes only the mdmctl and micromdm binaries
FROM unionpos/ubuntu:16.04

COPY --from=build /work/micromdm/build/linux /opt/bin
# EXPOSE 80 443
VOLUME ["/var/db/micromdm"]

# create mount point for volumes holding custom startup
RUN mkdir /docker-entrypoint.d

COPY scripts/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
