ARG POSTGRES_VERSION=13

# extension builder
FROM postgres:${POSTGRES_VERSION} AS extension_builder
ARG POSTGRES_VERSION=13
ARG PROXY=''

ENV PG_VERSION="$POSTGRES_VERSION"

RUN apt-get -o Acquire::http::proxy="$PROXY" update && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy dist-upgrade && \
    apt-get -o Acquire::http::proxy="$PROXY" install -qy \
      build-essential \
      git \
      libicu-dev \
      openssh-client \
      "postgresql-server-dev-${PG_VERSION}" \
      && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

RUN mkdir -p /root/.ssh/ && \
    chmod -R 600 /root/.ssh/ && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

RUN git clone https://github.com/tvondra/sequential-uuids.git /external_extensions/sequential-uuids
WORKDIR /external_extensions/sequential-uuids

RUN make clean && \
    make install

FROM postgres:${POSTGRES_VERSION}
ARG POSTGRES_VERSION=13
ARG PROXY=''

ENV PG_VERSION="${POSTGRES_VERSION}"

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    TERM="xterm" \
    TZ="Africa/Johannesburg"

COPY --from=extension_builder /usr/lib/postgresql/${POSTGRES_VERSION}/lib /usr/lib/postgresql/${POSTGRES_VERSION}/lib
COPY --from=extension_builder /usr/share/postgresql/${POSTGRES_VERSION}/extension /usr/share/postgresql/${POSTGRES_VERSION}/extension

RUN apt-get -o Acquire::http::proxy="$PROXY" update && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy dist-upgrade && \
    apt install -o Acquire::http::proxy="$PROXY" -qy \
      tzdata \
       && \
    rm /etc/localtime && \
    ln -s "/usr/share/zoneinfo/${TZ}" /etc/localtime && \
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

RUN mkdir -p /data

ADD ./files/docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
ADD ./files/postgres.conf /etc/postgresql/postgresql.conf

ENV MAX_CONNECTIONS='100' \
    SHARED_BUFFERS='512MB' \
    EFFECTIVE_CACHE_SIZE='1536MB' \
    MAINTENANCE_WORK_MEM='128MB' \
    CHECKPOINT_COMPLETION_TARGET='0.7' \
    WAL_BUFFERS='16MB' \
    DEFAULT_STATISTICS_TARGET='100' \
    RANDOM_PAGE_COST='1.1' \
    EFFECTIVE_IO_CONCURRENCY='200' \
    WORK_MEM='31457kB' \
    MIN_WAL_SIZE='1GB' \
    MAX_WAL_SIZE='2GB' \
    MAX_WORKER_PROCESSES='4' \
    MAX_PARALLEL_WORKERS_PER_GATHER='2' \
    MAX_PARALLEL_WORKERS='4'
