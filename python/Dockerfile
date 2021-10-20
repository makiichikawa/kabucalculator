FROM python:3.9 AS builder

WORKDIR /usr/src/app

COPY ./python/requirements.lock ./

RUN pip install --upgrade pip
RUN pip install -r requirements.lock

FROM python:3.9-slim

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY ./python ./
