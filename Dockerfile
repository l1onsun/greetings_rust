FROM rust:alpine as builder
WORKDIR /builder

# pre-requirements
RUN apk add --no-cache musl-dev binutils
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install just
COPY Justfile.docker ./Justfile

# build dependencies cache layer
RUN cargo init
COPY Cargo.toml Cargo.lock ./
RUN just build-release
RUN rm -rf src

# build real src
COPY src ./src
COPY templates ./templates
RUN touch src/main.rs
RUN just build-release
RUN just strip-release-binary

# app
FROM scratch
COPY --from=builder /builder/target/x86_64-unknown-linux-musl/release/app ./
COPY static ./static
COPY default_survey_config.json ./
CMD ["./app"]