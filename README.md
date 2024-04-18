# Vanilla OS Desktop Image

Containerfile for building a Vanilla OS Desktop image.

This image is based on top of [`vanillaos/core`](https://github.com/Vanilla-OS/core-image/pkgs/container/core) and offers the default
Vanilla OS Desktop experience with GNOME.

## Build

> [!NOTE]
> The fsguard compiled plugin `.so` file should be downloaded from the [latest release](https://github.com/Vanilla-OS/vib-fsguard/releases/latest) and be placed under a `plugins` directory beside the `recipe.yml` file.

```bash
vib build recipe.yml
podman image build -t vanillaos/desktop .
```
