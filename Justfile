set dotenv-load := true

release_app_path := "./target/x86_64-unknown-linux-musl/release/app"
cargo_target_arch :=  "--target=x86_64-unknown-linux-musl"
justd := "just -f Justfile.docker"
docker_builder_tag := "$DOCKER_REGISTRY/greetings-builder"
docker_app_tag := "$DOCKER_REGISTRY/greetings-app"

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
docker-build-builder: env-check
    docker build --target builder -t {{docker_builder_tag}} .
docker-push-builder: env-check
    docker image push {{docker_builder_tag}}
docker-build-app: env-check
    docker build -t {{docker_app_tag}} .
docker-push-app: env-check
    docker image push {{docker_app_tag}}
docker-run-app: env-check
    docker run --env-file .env --rm --network host {{docker_app_tag}}
docker-local-registry: env-check
    docker run -d -p $DOCKER_REGISTRY:5000 --restart=always --name rust-registry registry:2

# ELSE
strip-release-binary: env-check
    {{justd}} strip-release-binary
run-release-binary: env-check
    {{release_app_path}}
release: cargo-build-release strip-release-binary run-release-binary