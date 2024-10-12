# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt-get
ARG DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    x11vnc \
    xvfb \
    websockify \
    novnc \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the environment variable for screen resolution
ENV RESOLUTION 1707x1067

# Expose the port on which NoVNC runs (80 inside the container)
EXPOSE 80

# Copy the supervisord configuration file (make sure you create this file)
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Start the command to run NoVNC
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
