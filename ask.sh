#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

IMAGE="${DOCKER_TRIXIE_IMAGE:-myridia/trixie}"

show_menu() {
  printf "%s\n" '  ┌─────┬──────────────────────────────────────────────┐'
  printf "%s\n" '  │  ID │ Description                                  │'
  printf "%s\n" '  ├─────┼──────────────────────────────────────────────┤'
  printf "%s\n" '  │  1  │ Build — image myridia/trixie                  │'
  printf "%s\n" '  │  2  │ Build — no cache                             │'
  printf "%s\n" '  │  3  │ Push — myridia/trixie:latest to Docker Hub    │'
  printf "%s\n" '  │  4  │ Run — shell in the image                      │'
  printf "%s\n" '  │  5  │ Show — image list and size                    │'
  printf "%s\n" '  │  6  │ Remove — the image                            │'
  printf "%s\n" '  │  7  │ Clean — containers and volumes of the image   │'
  printf "%s\n" '  │  8  │ Clean — all containers, volumes and images    │'
  printf "%s\n" '  ├─────┼──────────────────────────────────────────────┤'
  printf "%s\n" '  │  0  │ Exit                                         │'
  printf "%s\n" '  └─────┴──────────────────────────────────────────────┘'
}

printf "\n  Docker Trixie — Task Runner\n\n"

while true; do
  show_menu

  printf "  Enter Task ID: "
  read task || exit 0

  if [ "$task" = "0" ]; then
    printf "  Goodbye!\n"
    exit 0
  fi

  if [ "$task" = "1" ]; then
    printf "...Building %s\n" "$IMAGE"
    DOCKER_BUILDKIT=0 docker build -t "$IMAGE" "$SCRIPT_DIR"

  elif [ "$task" = "2" ]; then
    printf "...Building %s (no cache)\n" "$IMAGE"
    DOCKER_BUILDKIT=0 docker build --no-cache -t "$IMAGE" "$SCRIPT_DIR"

  elif [ "$task" = "3" ]; then
    printf "...Pushing %s:latest to Docker Hub\n" "$IMAGE"
    printf "  (docker login first when the registry rejects the push)\n"
    docker push "$IMAGE:latest"

  elif [ "$task" = "4" ]; then
    printf "...Shell in %s\n" "$IMAGE"
    docker run --rm -it "$IMAGE" bash

  elif [ "$task" = "5" ]; then
    printf "...Images\n"
    docker images "$IMAGE"

  elif [ "$task" = "6" ]; then
    printf "...Removing %s\n" "$IMAGE"
    docker rmi "$IMAGE" 2>/dev/null || true

  elif [ "$task" = "7" ]; then
    printf "...Cleaning containers and volumes of %s\n" "$IMAGE"
    for c in $(docker ps -aq --filter "ancestor=$IMAGE"); do
      docker rm -f "$c" >/dev/null 2>&1 || true
    done
    docker volume rm $(docker volume ls -q --filter dangling=true) 2>/dev/null || true
    printf "  (containers of this image and dangling volumes removed)\n"

  elif [ "$task" = "8" ]; then
    printf "...Removing every container and the dangling volumes\n"
    printf "  This is the host-wide clean - it hits every project on this host.\n"
    printf "  Type CLEAN to continue: "
    read confirm
    if [ "$confirm" = "CLEAN" ]; then
      docker rm --force $(docker ps -qa) 2>/dev/null || true
      docker volume rm $(docker volume ls -q --filter dangling=true) 2>/dev/null || true
      printf "  (containers and dangling volumes removed)\n"
      printf "  Remove all images as well? [y/N] "
      read images
      case "$images" in
        y|Y)
          docker rmi --force $(docker images -aq) 2>/dev/null || true
          printf "  (all images removed)\n"
          ;;
        *) printf "  images kept\n" ;;
      esac
    else
      printf "  Aborted\n"
    fi

  else
    printf "  Unknown task: %s\n" "$task"
  fi

  sleep 2
  printf "\n"
done
