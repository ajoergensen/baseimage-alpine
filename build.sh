#!/bin/bash

for ver in 16 ; do docker build --pull --no-cache --force-rm=true -t baseimage-alpine:v3.$ver -f Dockerfile.v3.$ver . ; done
