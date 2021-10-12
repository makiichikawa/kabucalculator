FROM python:3.9 AS builder

WORKDIR /usr/src/app

COPY ./python/Pipfile ./python/Pipfile.lock ./

RUN pip install pipenv \
	&& pipenv install --system

FROM python:3.9-slim

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY ./python ./
