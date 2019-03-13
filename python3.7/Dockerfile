FROM syginc/awscli:python3.7

ADD bin /

RUN apt-get update && \
    apt-get install -y zip && \
    pip install --no-cache-dir --upgrade yq && \
    rm -rf /var/lib/apt/lists/*

ENV ARCHIVE_DIR="/work"

WORKDIR /work
