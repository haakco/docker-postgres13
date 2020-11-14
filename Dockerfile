FROM postgres:13

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    TERM="xterm" \
    TZ="Africa/Johannesburg"

#     docker-postgres13-ip4r \
#          docker-postgres13-jsquery \
#          docker-postgres13-pg-checksums \
#          docker-postgres13-pgmp \
#          docker-postgres13-postgis-3 \
#          docker-postgres13-postgis-3-scripts \
#          docker-postgres13-unit \
#          postgresql-contrib \
#      docker-postgres13-python3-multicorn \

RUN apt update && \
    mkdir -p /data && \
    apt install -qy \
      tzdata \
       && \
    rm /etc/localtime && \
    ln -s "/usr/share/zoneinfo/${TZ}" /etc/localtime && \
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

#RUN apt update && \
#    mkdir -p /data && \
#    apt install -qy \
#      python-pip \
#      python3-pip \
#       && \
#    pip3 install Faker && \
#    pip3 install https://github.com/haakco/faker_fdw/archive/master.zip && \
#    apt -y autoremove && \
#    apt -y clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /var/tmp/* && \
#    rm -rf /tmp/*

ADD ./files/docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
ADD ./files/postgres.conf /etc/postgresql/postgresql.conf

ENV MAX_CONNECTIONS = 100 \
    SHARED_BUFFERS = 512MB \
    EFFECTIVE_CACHE_SIZE = 1536MB \
    MAINTENANCE_WORK_MEM = 128MB \
    CHECKPOINT_COMPLETION_TARGET = 0.7 \
    WAL_BUFFERS = 16MB \
    DEFAULT_STATISTICS_TARGET = 100 \
    RANDOM_PAGE_COST = 1.1 \
    EFFECTIVE_IO_CONCURRENCY = 200 \
    WORK_MEM = 31457kB \
    MIN_WAL_SIZE = 1GB \
    MAX_WAL_SIZE = 2GB \
    MAX_WORKER_PROCESSES = 4 \
    MAX_PARALLEL_WORKERS_PER_GATHER = 2 \
    MAX_PARALLEL_WORKERS = 4
