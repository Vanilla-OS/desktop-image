# Vanilla OS Desktop Image

Containerfile for building a Vanilla OS Desktop image.

This image is based on top of [`vanillaos/core`](https://github.com/Vanilla-OS/core-image/pkgs/container/core) and offers the default
Vanilla OS Desktop experience with GNOME.

## Build

```bash
sh prepare.sh
podman image build -t vanillaos/desktop .
```
