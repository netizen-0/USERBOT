FROM python:3.10-slim

# Install build dependencies for pycairo
RUN apt-get update && apt-get install -y \
    libcairo2-dev \
    pkg-config \
    python3-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Now install requirements
COPY requirements.txt .
RUN pip install -U pip
RUN pip install -U -r requirements.txt
