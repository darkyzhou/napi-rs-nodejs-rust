FROM debian:trixie

ARG RUSTUP_VERSION="1.27.1"
ARG RUST_ARCH="x86_64-unknown-linux-gnu"
ARG RUST_TARGET_ARCH="loongarch64-unknown-linux-gnu"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    gcc-14-loongarch64-linux-gnu \
    g++-14-loongarch64-linux-gnu \
    binutils-loongarch64-linux-gnu \
    build-essential \
    llvm-18 \
    clang-18 \
    lld-18 \
    libc++-18-dev \
    libc++abi-18-dev \
    nodejs \
    npm

RUN apt-get install -y --no-install-recommends ca-certificates curl

RUN curl "https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/${RUST_ARCH}/rustup-init" -o rustup-init && \
  chmod +x rustup-init && \
  CARGO_HOME=/usr ./rustup-init -y --default-toolchain stable --profile minimal && \
  rm rustup-init && \
  rustup target add ${RUST_TARGET_ARCH}

ADD config.toml /root/.cargo/config.toml

ENV CC=clang-18 CXX=clang++-18
