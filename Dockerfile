# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH server and clean up
RUN apt-get update \
    && apt-get install -y openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Generate SSH keys (you can replace them with your own)
RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin without-password/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && ssh-keygen -A

# Expose SSH port
EXPOSE 22

# Create authorized_keys file if AUTHORIZED_KEYS is not empty, then start SSH server
CMD /bin/sh -c "[ -n \"$AUTHORIZED_KEYS\" ] && mkdir -p /root/.ssh && echo \"$AUTHORIZED_KEYS\" > /root/.ssh/authorized_keys; /usr/sbin/sshd -D"
