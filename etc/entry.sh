#!/bin/bash

# Create steam app directory
mkdir -p "${STEAMAPPDIR}" || true

# Download updates
bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login "anonymous" \
    +app_update "${STEAMAPPID}" \
    +quit

# Switch to server directory
cd "${STEAMAPPDIR}"

# Check architecture
if [ "$(uname -m)" = "aarch64" ]; then
    # ARM64 architecture
	# create an arm64 version of srcds_run
	cp ./srcds_run ./srcds_run-arm64
    SRCDS_RUN="srcds_run-arm64"
    sed -i 's/$HL_CMD/box86 $HL_CMD/g' "$SRCDS_RUN"
    chmod +x "$SRCDS_RUN"
else
    # Other architectures
    SRCDS_RUN="srcds_run"
fi

# Start server
"./$SRCDS_RUN" -game cstrike \
	"${CSS_ARGS}" \
    +clientport "${CSS_CLIENTPORT}" \
    +map "${CSS_MAP}" \
    +sv_lan "${CSS_LAN}" \
    +tv_port "${CSS_SOURCETVPORT}" \
    -autoupdate \
    -console \
    -ip "${CSS_IP}" \
    -master \
    -maxplayers "${CSS_MAXPLAYERS}" \
    -port "${CSS_PORT}" \
    -strictportbind \
    -tickrate "${CSS_TICKRATE}" \
    -usercon