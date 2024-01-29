FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3-mapnik \
    # Clean up in the same layer to reduce image size
    && rm -rf /var/lib/apt/lists/* \
    # Use a non-root user for security purposes
    && useradd -m admin \
    && echo "admin:admin" | chpasswd \
    && adduser admin sudo

USER admin

WORKDIR /app

CMD ["bash"]