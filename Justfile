set dotenv-load := true

release_app_path := "./target/x86_64-unknown-linux-musl/release/app"
cargo_target_arch :=  "--target=x86_64-unknown-linux-musl"
justd := "just -f Justfile.docker"

default: env-check
  just --list

# ENV
env-check:
    dotenv-linter
    dotenv-linter compare .env .env.local
env-fix:
    dotenv-linter fix
env:
    env

# CARGO
cargo-build-release: env-check
    {{justd}} build-release
cargo-test-release: env-check
    {{justd}} test-release
cargo-run: env-check
    cargo run {{cargo_target_arch}}


# DOCKER
docker-build: env-check
    ./pipeline_scripts/docker-build-app.sh
docker-push: env-check
    ./pipeline_scripts/docker-push-app.sh
docker-run: env-check
    docker run --env-file .env --rm --network host $DOCKER_REGISTRY/$BUILDER_TAG
docker-registry: env-check
    docker run -d -p $DOCKER_REGISTRY:5000 --restart=always --name rust-registry registry:2

# ELSE
strip-release-binary: env-check
    {{justd}} strip-release-binary
run-release-binary: env-check
    {{release_app_path}}
release: cargo-build-release strip-release-binary run-release-binary