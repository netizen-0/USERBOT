FROM python:3.10-alpine
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until
RUN apk add --no-cache \
    cairo-dev \
    pkgconfig \
    musl-dev \
    gcc \
    g++

COPY requirements.txt .
RUN pip install -U pip
RUN pip install -U -r requirements.txt

    
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git curl python3-pip ffmpeg && \
    apt-get clean

RUN pip3 install --upgrade pip
COPY . /app/
WORKDIR /app/
RUN pip3 install -U -r requirements.txt
CMD ["bash", "start.sh"]
