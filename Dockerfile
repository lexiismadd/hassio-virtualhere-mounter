ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.8
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
ARG BUILD_ARCH=amd64
# hadolint ignore=DL3003,DL3042
RUN apk add --no-cache \
    kmod=30-r3 \
    linux-tools-usbip=6.3.12-r0 \
    hwdata-usb=0.370-r0 \
    device-mapper-libs=2.03.21-r3

# Copy root filesystem
COPY rootfs /

# Download the client
RUN wget https://www.virtualhere.com/sites/default/files/usbclient/vhclientx86_64 -P /usr/sbin
RUN chmod +x /usr/sbin/vhclientx86_64

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Lexi <alexismadd@outlook.com.au>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Lexi <alexismadd@outlook.com.au>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
