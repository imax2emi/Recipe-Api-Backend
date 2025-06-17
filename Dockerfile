FROM python:3.9-alpine3.13

LABEL maintainer="Ijong Maxwell"

ENV PYTHONUNBUFFERED=1 \
    PATH="/py/bin:$PATH" \
    PIP_NO_CACHE_DIR=off

ARG DEV=false

# Copy requirement files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Copy app source
COPY ./app /app

WORKDIR /app
EXPOSE 8000

# Install base system dependencies and virtualenv
RUN apk add --no-cache \
    build-base \
    linux-headers \
    postgresql-dev \
    musl-dev \
    libffi-dev \
    openssl-dev \
    libpq \
    bash \
    postgresql-client && \
    python -m venv /py && \
    /py/bin/pip install --upgrade pip

# Install Python dependencies
RUN set -ex && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp

# Create non-root user
RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

USER django-user


