FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Build arguments
ARG DEVICELAB_URL
ARG TEST_NODE_PORT=4723

# Set environment variables
ENV DEVICELAB_URL=${DEVICELAB_URL}
ENV TEST_NODE_PORT=${TEST_NODE_PORT}

# Create directory structure
RUN mkdir -p /root/Downloads
WORKDIR /root

# Copy APK file
COPY app-release.apk /root/Downloads/app-release.apk

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose test node port
EXPOSE ${TEST_NODE_PORT}

# Start DeviceLab test node
ENTRYPOINT ["/entrypoint.sh"]