FROM registry.vanillaos.org/vanillaos/core:main
LABEL maintainer="Vanilla OS Contributors"

# Copy bucket in /tmp
COPY bucket /tmp/bucket

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $(cat /tmp/bucket/install.packages) && \
    apt-get clean
