FROM ianhorn/python311-nanoserver:1.0.0 as base

# Any python libraries that require system libraries to be installed will likely
# need the following packages in order to build

# ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

FROM base as builder

WORKDIR /app

COPY . /app

RUN python -m pip install --no-cache-dir --user --upgrade pip && \
    python -m pip install -e ./stac_fastapi/types[dev] && \
    python -m pip install -e ./stac_fastapi/api[dev] && \
    python -m pip install -e ./stac_fastapi/extensions[dev]
