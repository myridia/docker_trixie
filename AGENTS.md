# AGENTS.md — docker_trixie

## What this is
Docker image based on Debian Trixie (node:20-trixie) with Rust, build tools, proxychains, and common dev libraries.

## Stack
- Debian Trixie (node:20)
- Rust (via rustup)
- Poetry (via pipx)
- .NET SDK 10.0 + ASP.NET Core runtime 10.0 (packages.microsoft.com repo)
- redsocks / proxychains4
- Build essentials (cmake, gcc, boost, openssl, etc.)

## Task runner (`ask.sh`)
POSIX `sh` menu, modelled on `gitlab/tibellus/ask.sh`. The user runs it; the agent never does.

| ID | Task |
|----|------|
| 1 | Build the image `myridia/trixie` |
| 2 | Build without cache |
| 3 | Push `myridia/trixie:latest` to Docker Hub |
| 4 | Shell in the image |
| 5 | Show the image list and size |
| 6 | Remove the image |
| 7 | Clean the containers of this image and the dangling volumes |
| 8 | Clean everything: all containers, dangling volumes, optionally all images (asks for `CLEAN`) |
| 0 | Exit |

- The image name is `DOCKER_TRIXIE_IMAGE` (default `myridia/trixie`).
- The old `build.sh` and `clean.sh` are gone — their commands are tasks 1 and 8. The legacy builder flag was dropped: the CI workflow builds with BuildKit, and the classic builder is deprecated.
- **Task 8 is host-wide**: it removes every container on the host, not just this project's. Task 7 is the scoped one. Both were asked for by name (`CLEAN`), and the image removal is a second, separate confirmation.
- The CI workflow `.github/workflows/publish_docker.yml` builds and pushes `myridia/trixie:latest` on push to `main`; its `metadata-action` is configured for the image name `myridia/docker_trixie`, so the labels refer to a different name than the image that is pushed.

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
- `ask.sh` — task runner (build, push, run, clean)

## Conventions
- No comments in code unless asked.
