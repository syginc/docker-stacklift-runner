FROM syginc/awscli:3.7

ADD bin /

RUN apt-get update && \
    apt-get install -y zip && \
    pip install --no-cache-dir --upgrade yq && \
    rm -rf /var/lib/apt/lists/*

ENV CONFIG_FILE="src/config.yaml" \
    CONFIG_IN_FILE="src/config.in.yaml"

WORKDIR /work
