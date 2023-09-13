# SSH-Enabled Ubuntu Docker Image

This Docker image provides an Ubuntu 22.04 base with SSH server enabled. It allows you to easily create SSH-accessible containers via ssh keys.

## Usage

### Building the Docker Image

1. Clone this repository or create a Dockerfile based on the provided instructions.

2. Build the Docker image. You can specify the image name and tag as desired:

   ```bash
   docker build -t aoudiamoncef/ubuntu-sshd:latest .
   ```

### Running a Container

To run a container based on the image, use the following command:

```bash
docker run -d -p host-port:22 -e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)" aoudiamoncef/ubuntu-sshd:latest
```

- `-d` runs the container in detached mode.
- `-p host-port:22` maps a host port to port 22 in the container. Replace `host-port` with your desired port.
- `-e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)"` sets authorized SSH keys in the container. Replace `path/to/authorized_keys_file` with the path to your authorized_keys file.
- `aoudiamoncef/ubuntu-sshd:latest` should be replaced with your Docker image's name and tag.

### SSH Access

Once the container is running, you can SSH into it using the following command:

```bash
ssh -p host-port root@localhost
```

- `host-port` should match the port you specified when running the container.

### Note

- If the `AUTHORIZED_KEYS` environment variable is empty when starting the container, it will still launch the SSH server, but no authorized keys will be configured. You have to mount your own authorized keys file or manually configure the keys in the container.

## License

This Docker image is provided under the [MIT License](LICENSE).