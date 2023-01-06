#!/bin/bash
set -eu
BASE_URL=https://raw.githubusercontent.com/htcondor/htcondor/main/build/docker/services/base

SCRIPTS=("container-install-htcondor.sh" "pre-exec.sh" "start.sh" "update-config" "update-secrets")
CONFIGS=("supervisord.conf" "condor/01-misc.conf" "condor/01-security.conf")
DST="/root/bootstrap/scripts"

mkdir -p $DST

for f in ${SCRIPTS[@]}
do
  wget -O $DST/$f ${BASE_URL}/$f
  chmod a+x $DST/$f
done

DST="/root/bootstrap/config"
mkdir -p $DST/condor
for f in ${CONFIGS[@]}
do
  wget -O $DST/$f ${BASE_URL}/$f
done
set +eu
