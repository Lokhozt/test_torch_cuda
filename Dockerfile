FROM python:3.8
LABEL maintainer="rbaraglia@linagora.com"
ENV PYTHONUNBUFFERED TRUE

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    ca-certificates \
    g++ \
    openjdk-11-jre-headless \
    curl \
    wget

# Rust compiler for tokenizers
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /usr/src/app

# Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY test_torch.py /usr/src/app/test_torch.py

ENTRYPOINT ["./test_torch.py"]