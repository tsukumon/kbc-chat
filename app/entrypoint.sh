#!bin/bash

#if error, stop script
set -e

#already running server kill
rm -f /myapp/tmp/pids/server.pid

#RUN CMD in Dockerfile
exec "$@"