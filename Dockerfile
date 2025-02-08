FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64  as base

# Any python libraries that require system libraries to be installed will likely
# need the following packages in order to build
# Refactor with Chocolatey
RUN powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

RUN refreshenv && \
    choco install git -y && \
    choco install psql -y  && \
    choco install python312 -y && \
    refreshenv

FROM base as builder

ENV PATH="C:/Python312;C:/Program Files/Git/bin;C/Program Files/Git/cmd;C:/ProgramData/chocolatey/bin;%PATH%"

WORKDIR /app

COPY . /app

RUN python -m pip install -e ./stac_fastapi/types[dev] && \
    python -m pip install -e ./stac_fastapi/api[dev] && \
    python -m pip install -e ./stac_fastapi/extensions[dev]
