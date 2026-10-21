<img src="docker_trixie.svg" alt="docker_trixie" width="120">

# docker-trixie 
docker debian trixie with all rust goodies

Debian Trixie (`node:20-trixie`) with Rust (rustup), Poetry (pipx), the
.NET SDK 10.0, proxychains4/redsocks, emacs-nox and the usual dev libraries
(cmake, boost, openssl, sqlite, python3/ruby dev).

## Usage

Everything runs through the task runner:

```bash
./ask.sh
```

| ID | Task |
|----|------|
| 1 | Build the image `myridia/trixie` |
| 2 | Build without cache |
| 3 | Push `myridia/trixie:latest` to Docker Hub |
| 4 | Shell in the image |
| 5 | Show the image list and size |
| 6 | Remove the image |
| 7 | Clean the containers of this image and the dangling volumes |
| 8 | Clean everything: all containers, dangling volumes, optionally all images |
| 0 | Exit |

The image name can be changed with `DOCKER_TRIXIE_IMAGE`.

The GitHub Actions workflow `.github/workflows/publish_docker.yml` builds and
pushes the same image on every push to `main`.
