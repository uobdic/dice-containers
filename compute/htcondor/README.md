# HTCondor service containers

## Starting Condor Manager (collector/negotiator)

On the host:

```bash
git clone https://github.com/uobdic/dice-containers.git
pushd dice-containers/compute/htcondor

mkdir -p ~/condorexec/secrets
chmod 0700 ~/condorexec/secrets

echo "CONDOR_HOST=$(hostname -f)" > ~/condorexec/env
echo "UID_DOMAIN=phy.bris.ac.uk" >> ~/condorexec/env

docker run -d --name condor-manager --restart always \
  --env-file=~/condorexec/env \
  -v ~/condorexec/secrets:/root/secrets:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/manager:/root/config:ro \
  -v /etc/grid-security:/etc/grid-security-orig.d:ro \
  -v /etc/condor/tokens.d:/etc/condor/tokens-orig.d:ro \
  -v /etc/condor/passwords.d/:/etc/condor/passwords-orig.d/:ro \
  -p 9618:9618 \
  kreczko/htcondor
```

## Starting a worker (execute node)

On the host:

```bash
git clone https://github.com/uobdic/dice-containers.git
pushd dice-containers/compute/htcondor

mkdir -p ~/condorexec/secrets
chmod 0700 ~/condorexec/secrets

echo "CONDOR_HOST=<manager host>)" > ~/condorexec/env
echo "UID_DOMAIN=phy.bris.ac.uk" >> ~/condorexec/env

docker run -d --name condor-worker --restart always \
  --env-file=~/condorexec/env \
  -v ~/condorexec/secrets:/root/secrets:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/worker:/root/config:ro \
  -v /etc/grid-security:/etc/grid-security-orig.d:ro \
  -v /etc/condor/tokens.d:/etc/condor/tokens-orig.d:ro \
  -v /etc/condor/passwords.d/:/etc/condor/passwords-orig.d/:ro \
  -p 9618:9618 \
  kreczko/htcondor
```

## Starting a scheduler (submit node)

On the host:

```bash
git clone https://github.com/uobdic/dice-containers.git
pushd dice-containers/compute/htcondor

mkdir -p ~/condorexec/secrets
chmod 0700 ~/condorexec/secrets

echo "CONDOR_HOST=<manager host>)" > ~/condorexec/env
echo "UID_DOMAIN=phy.bris.ac.uk" >> ~/condorexec/env

docker run -d --name condor-worker --restart always \
  --env-file=~/condorexec/env \
  -v ~/condorexec/secrets:/root/secrets:ro \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/worker:/root/config:ro \
  -v /etc/grid-security:/etc/grid-security-orig.d:ro \
  -v /etc/condor/tokens.d:/etc/condor/tokens-orig.d:ro \
  -v /etc/condor/passwords.d/:/etc/condor/passwords-orig.d/:ro \
  -p 9618:9618 \
  kreczko/htcondor
```
