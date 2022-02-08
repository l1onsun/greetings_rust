set dotenv-load := true

build:
    cargo build --target=x86_64-unknown-linux-musl

build-release:
    cargo build --target=x86_64-unknown-linux-musl --release

run:
    cargo run --target=x86_64-unknown-linux-musl