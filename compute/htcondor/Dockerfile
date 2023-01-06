# from https://github.com/htcondor/htcondor/tree/main/build/docker/services/base
ARG BASE_IMAGE=almalinux:8
FROM ${BASE_IMAGE}
ARG BASE_IMAGE
# ^^ Previous BASE_IMAGE has gone out of scope

ARG VERSION=latest
ARG SERIES=10.2

LABEL org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.title="HTCondor Base Image derived from ${BASE_IMAGE}" \
      org.opencontainers.image.vendor="HTCondor"

# Unset these from parent
LABEL \
    build-date="" \
    io.buildah.version="" \
    license="" \
    name="" \
    org.label-schema.build-date="" \
    org.label-schema.license="" \
    org.label-schema.name="" \
    org.label-schema.schema-version="" \
    org.label-schema.vendor="" \
    org.opencontainers.image.created="" \
    vendor=""

# customizations
RUN dnf update -y \
 && dnf install -y wget \
 && dnf clean all \
 && rm -rf /var/cache/yum

COPY get-htcondor-scripts.sh /root/bootstrap/scripts/get-htcondor-scripts.sh
RUN bash -x /root/bootstrap/scripts/get-htcondor-scripts.sh

RUN \
  export HTCONDOR_VERSION=${VERSION} HTCONDOR_SERIES=${SERIES}; \
  bash -x /root/bootstrap/scripts/container-install-htcondor.sh

COPY customize-htcondor.sh /root/bootstrap/scripts/customize-htcondor.sh
RUN bash -x /root/bootstrap/scripts/customize-htcondor.sh

RUN mkdir -p /root/config
RUN cp -p /root/bootstrap/config/condor/*.conf /etc/condor/config.d/ \
 && cp -p /root/bootstrap/config/supervisord.conf /etc/supervisord.conf \
 && cp -p /root/bootstrap/scripts/pre-exec.sh /root/config/pre-exec.sh \
 && cp -p /root/bootstrap/scripts/start.sh / \
 && cp -p /root/bootstrap/scripts/update-config / \
 && cp -p /root/bootstrap/scripts/update-secrets /

CMD ["/bin/bash", "-x", "/start.sh"]

EXPOSE 9618
