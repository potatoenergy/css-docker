**Counter-Strike: Source Server Docker Image**
===========================================

Run a Counter-Strike: Source server easily inside a Docker container, optimized for ARM64 (using box86).

**Supported tags**
-----------------

* `latest` - the most recent production-ready image, based on `sonroyaalmerol/steamcmd-arm64:root`

**Documentation**
----------------

### Ports
The container uses the following ports:
* `:27015 TCP/UDP` as the game transmission, pings and RCON port
* `:27005 UDP` as the client port

### Environment variables

* `CSS_ARGS`: Additional arguments to pass to the server.
* `CSS_CLIENTPORT`: The client port for the server.
* `CSS_IP`: The IP address for the server.
* `CSS_LAN`: Whether the server is LAN-only or not.
* `CSS_MAP`: The map for the server.
* `CSS_MAXPLAYERS`: The maximum number of players allowed to join the server.
* `CSS_PORT`: The port for the server.
* `CSS_SERVERCFG`: The server configuration file.
* `CSS_SOURCETVPORT`: The Source TV port for the server.
* `CSS_TICKRATE`: The tick rate for the server.

### Directory structure
The following directories and files are important for the server:

```
📦 /home/steam
|__📁cstrike-server // The server root (css folder name using env)
|  |__📁cstrike
|  |  |__📁cfg
|  |  |  |__⚙️server.cfg
|  |  |__📁custom
|  |  |__📁maps // Put your maps here
|__📃srcds_run // Script to start the server
|__📃srcds_run-arm64 // Script to start the server on ARM64
```

### Examples

This will start a simple server in a container named `css-server`:
```sh
docker run -d --name css-server \
  -p 27005:27005/udp \
  -p 27015:27015 \
  -p 27015:27015/udp \
  -e CSS_ARGS="" \
  -e CSS_CLIENTPORT=27005 \
  -e CSS_IP="" \
  -e CSS_LAN="0" \
  -e CSS_MAP="de_dust2" \
  -e CSS_MAXPLAYERS="12" \
  -e CSS_PORT=27015 \
  -e CSS_SERVERCFG="" \
  -e CSS_SOURCETVPORT="27020" \
  -e CSS_TICKRATE="" \
  -v /home/ponfertato/Docker/css-server:/home/steam/cstrike-server/cstrike \
  ponfertato/css:latest
```

...or Docker Compose:
```sh
version: '3'

services:
  css-server:
    container_name: css-server
    restart: unless-stopped
    image: ponfertato/css:latest
    tty: true
    stdin_open: true
    ports:
      - "27005:27005/udp"
      - "27015:27015"
      - "27015:27015/udp"
    environment:
      - CSS_ARGS=""
      - CSS_CLIENTPORT=27005
      - CSS_IP=""
      - CSS_LAN="0"
      - CSS_MAP="de_dust2"
      - CSS_MAXPLAYERS="12"
      - CSS_PORT=27015
      - CSS_SERVERCFG=""
      - CSS_SOURCETVPORT="27020"
      - CSS_TICKRATE=""
    volumes:
      - ./css-server:/home/steam/cstrike-server/cstrike
```

**Health Check**
----------------

This image contains a health check to continually ensure the server is online. That can be observed from the STATUS column of docker ps

```sh
CONTAINER ID        IMAGE                    COMMAND                 CREATED             STATUS                    PORTS                                                                                     NAMES
e9c073a4b262        ponfertato/css            "/home/steam/entry.sh"   21 minutes ago      Up 21 minutes (healthy)   0.0.0.0:27005->27005/udp, 0.0.0.0:27015->27015/tcp, 0.0.0.0:27015->27015/udp   distracted_cerf
```

**License**
----------

This image is under the [MIT license](LICENSE).