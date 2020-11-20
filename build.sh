#!/bin/bash

for ver in 9 10 11 12 ; do docker build --pull --no-cache --force-rm=true -t baseimage-alpine:v3.$ver -f Dockerfile.v3.$ver . ; done
