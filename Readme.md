# Greetings Rust
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
