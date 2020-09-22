#!/usr/bin/env bash
sed -Ei \
  -e "s/max_connections = .*/max_connections = ${MAX_CONNECTIONS}/" \
  -e "s/shared_buffers = .*/shared_buffers = ${SHARED_BUFFERS}/"  \
  -e "s/effective_cache_size = .*/effective_cache_size = ${EFFECTIVE_CACHE_SIZE}/"  \
  -e "s/maintenance_work_mem = .*/maintenance_work_mem = ${MAINTENANCE_WORK_MEM}/"  \
  -e "s/checkpoint_completion_target = .*/checkpoint_completion_target = ${CHECKPOINT_COMPLETION_TARGET}/"  \
  -e "s/wal_buffers = .*/wal_buffers = ${WAL_BUFFERS}/"  \
  -e "s/default_statistics_target = .*/default_statistics_target = ${DEFAULT_STATISTICS_TARGET}/"  \
  -e "s/random_page_cost = .*/random_page_cost = ${RANDOM_PAGE_COST}/"  \
  -e "s/effective_io_concurrency = .*/effective_io_concurrency = ${EFFECTIVE_IO_CONCURRENCY}/"  \
  -e "s/work_mem = .*/work_mem = ${WORK_MEM}/"  \
  -e "s/min_wal_size = .*/min_wal_size = ${MIN_WAL_SIZE}/"  \
  -e "s/max_wal_size = .*/max_wal_size = ${MAX_WAL_SIZE}/"  \
  -e "s/max_worker_processes = .*/max_worker_processes = ${MAX_WORKER_PROCESSES}/"  \
  -e "s/max_parallel_workers_per_gather = .*/max_parallel_workers_per_gather = ${MAX_PARALLEL_WORKERS_PER_GATHER}/"  \
  -e "s/max_parallel_workers = .*/max_parallel_workers = ${MAX_PARALLEL_WORKERS}/"  \
  /etc/postgresql/postgresql.conf

cat /etc/postgresql/postgresql.conf
