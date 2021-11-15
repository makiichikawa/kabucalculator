FROM python:3.9 AS builder

WORKDIR /usr/src/app

COPY ./python/requirements.lock ./

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.lock

FROM python:3.9-slim

WORKDIR /python

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY ./python ./
