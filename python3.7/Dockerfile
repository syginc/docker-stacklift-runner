FROM ghcr.io/syginc/awscli:python3.7

RUN apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --use-deprecated=legacy-resolver --upgrade yq stacklift==0.0.10 emrichen==0.2.0 awscli==1.22.29

ADD bin /

ENV MODULE_DIR="/work" \
    MODULE_OVERWRITE_DIR="/overwrite"

WORKDIR /work
