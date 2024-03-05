FROM debian:latest

ENV APT_PACKAGES apt-transport-https ca-certificates dirmngr gnupg mosquitto postgresql redis-server supervisor
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --yes --no-install-recommends ${APT_PACKAGES} \
    && apt-get autoremove --yes \
    && apt-get clean

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1CE2AFD36DBCCA00 \
    && echo "deb https://artifacts.chirpstack.io/packages/4.x/deb stable main" > /etc/apt/sources.list.d/chirpstack.list
ENV APT_PACKAGES chirpstack chirpstack-gateway-bridge 
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --yes --no-install-recommends ${APT_PACKAGES} \
    && apt-get autoremove --yes \
    && apt-get clean

RUN usermod -u 10000 postgres
RUN ln -s /usr/lib/postgresql/*/bin/initdb /usr/bin/initdb
RUN ln -s /usr/lib/postgresql/*/bin/postgres /usr/bin/postgres

COPY ./files/mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY ./files/postgres-init.tar.gz /var/postgres-init.tar.gz
COPY ./files/redis.conf /etc/redis/redis.conf
COPY ./files/supervisord.conf /etc/supervisord.conf

COPY ./files/start.sh /usr/libexec/start.sh
CMD [ "/usr/libexec/start.sh" ]
