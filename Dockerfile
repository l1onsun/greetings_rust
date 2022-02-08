FROM rust:latest as builder
WORKDIR /builder

# build requirements
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install just

# build dependencies only
RUN cargo init
COPY Cargo.toml Cargo.lock ./
RUN cargo build --target=x86_64-unknown-linux-musl --release
RUN rm -rf src/*.rs

# build our src
COPY Cargo.toml Cargo.lock ./
COPY src ./
RUN just build-release

FROM scratch
WORKDIR /app
COPY --from=builder /builder/target/x86_64-unknown-linux-musl/release/app ./
COPY res ./
CMD ["./app"]