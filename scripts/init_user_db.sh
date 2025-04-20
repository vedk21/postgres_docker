#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create user docker with password '$DOCKER_PASSWORD';
    grant connect on database test to docker;
    create schema if not exists fiddle;
    grant all on schema fiddle to docker;
    set search_path to fiddle,public;
EOSQL

psql -v ON_ERROR_STOP=1 --username docker --dbname test <<-EOSQL
    SET search_path TO fiddle, public;
    ALTER USER docker SET search_path TO fiddle, public;
    \i /scripts/create_table.sql
EOSQL