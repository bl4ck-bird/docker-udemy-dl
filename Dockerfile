FROM python:3-alpine

LABEL maintainer="bl4ckbird <bl4ckbird@bl4ckbird.com>"

RUN wget https://github.com/r0oth3x49/udemy-dl/archive/master.zip -O /udemy-dl.zip \
    && unzip /udemy-dl.zip -d / \
    && rm -f /udemy-dl.zip \
    && mv /udemy-dl-master /udemy-dl \
    && pip3 install -r /udemy-dl/requirements.txt

RUN mkdir /downloads && chmod a+rw /downloads

WORKDIR /downloads

VOLUME ["/downloads"]

ENTRYPOINT ["python3", "/udemy-dl/udemy-dl.py", "-o", "/downloads"]
