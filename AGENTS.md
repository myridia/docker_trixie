# AGENTS.md — docker_trixie

## What this is
Docker image based on Debian Trixie (node:20-trixie) with Rust, build tools, proxychains, and common dev libraries.

## Stack
- Debian Trixie (node:20)
- Rust (via rustup)
- Poetry (via pipx)
- redsocks / proxychains4
- Build essentials (cmake, gcc, boost, openssl, etc.)

## Build
```bash
docker build -t myridia/trixie .
```

## Run
```bash
docker run -it myridia/trixie bash
```

## Structure
- `Dockerfile` — Trixie image with full dev toolchain
- `build.sh` — build script
- `clean.sh` — cleanup script

## Conventions
- No comments in code unless asked.
