# Greetings Rust
[![Pipeline Status](https://drone.cherezov.space/api/badges/lionsoon/greetings_rust/status.svg)](https://drone.cherezov.space/lionsoon/greetings_rust)
[![Website status](https://img.shields.io/website?down_color=lightgrey&down_message=down&up_message=up&url=https%3A%2F%2Fxi.cherezov.space)](https://xi.cherezov.space)
## pre-requirements
```sh
> cp .env.example .env
> cargo install dotenv-linter
> cargo install just
```
## run local
debug:
```sh
> just cargo-run
```
release:
```sh
> just release
```
## run docker
```sh
> just docker-build
> just docker-run
```
