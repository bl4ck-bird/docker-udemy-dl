FROM python:3-alpine

LABEL maintainer="bl4ckbird <bl4ckbird@bl4ckbird.com>"

RUN apk add --no-cache --virtual .build-deps curl build-base libffi-dev openssl-dev \
    \
    && wget https://github.com/r0oth3x49/udemy-dl/archive/master.zip -O /udemy-dl.zip \
    && unzip /udemy-dl.zip -d / \
    && rm -f /udemy-dl.zip \
    && mv /udemy-dl-master /udemy-dl \
    \
    && export CRYPTOGRAPHY_DONT_BUILD_RUST=1 \
    && pip3 install -r /udemy-dl/requirements.txt \
    \
    && rm -rf ~/.cache/pip \
    && apk add --no-cache curl openssl libffi \
    && apk del --no-network .build-deps

RUN mkdir /downloads && chmod a+rw /downloads

WORKDIR /downloads

VOLUME ["/downloads"]

ENTRYPOINT ["python3", "/udemy-dl/udemy-dl.py", "-o", "/downloads"]
