FROM registry.vanillaos.org/vanillaos/core:main
LABEL maintainer="Vanilla OS Contributors"

# Copy bucket in /tmp
COPY bucket /tmp/bucket

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $(cat /tmp/bucket/install.packages) && \
    apt-get clean

# Set default PATH
RUN echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"' > /etc/environment
RUN sed -i '4,10d' /etc/profile
