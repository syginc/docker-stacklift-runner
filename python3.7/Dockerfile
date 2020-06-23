FROM syginc/awscli:python3.7

RUN apt-get update && \
    apt-get install -y zip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade yq stacklift==0.0.11 emrichen==0.2.0

ADD bin /

ENV MODULE_DIR="/work" \
    MODULE_OVERWRITE_DIR="/overwrite"

WORKDIR /work
