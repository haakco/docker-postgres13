CREATE EXTENSION adminpack;
CREATE EXTENSION dblink;
CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION "pg_buffercache";
CREATE EXTENSION pgcrypto;
CREATE EXTENSION hstore;
CREATE EXTENSION multicorn;

DROP SCHEMA IF EXISTS fake CASCADE ;
DROP SERVER IF EXISTS faker_srv CASCADE;

# CREATE SERVER faker_srv
#     FOREIGN DATA WRAPPER multicorn
#     OPTIONS (wrapper 'faker_fdw.FakerForeignDataWrapper');
#
# CREATE SCHEMA faker;
# IMPORT FOREIGN SCHEMA fake
#     FROM SERVER faker_srv
#     INTO faker
#     OPTIONS ( locale 'en_UK', max_results '10000000');
