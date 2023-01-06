#!/usr/bin/env bash
set -eu

sed -i "s/dockerworker@example.net/worker@phy.bris.ac.uk/g" /root/bootstrap/config/condor/*.conf
sed -i "s/dockersubmit@example.net/submit@phy.bris.ac.uk/g" /root/bootstrap/config/condor/*.conf

set +eu
