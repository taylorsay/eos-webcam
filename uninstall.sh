#!/usr/bin/env bash
set -euo pipefail

BINARY_NAME="eos-webcam"
INSTALL_DIR="$HOME/.local/bin"
SERVICE_NAME="eos-webcam.service"
SERVICE_DIR="$HOME/.config/systemd/user"

info() { echo "==> $*"; }

info "Stopping and disabling service..."
systemctl --user stop    "$SERVICE_NAME" 2>/dev/null || true
systemctl --user disable "$SERVICE_NAME" 2>/dev/null || true
rm -f "$SERVICE_DIR/$SERVICE_NAME"
systemctl --user daemon-reload

info "Removing binary..."
rm -f "$INSTALL_DIR/$BINARY_NAME"

info "Removing system config files (requires sudo)..."
sudo rm -f /etc/modprobe.d/eos-webcam.conf
sudo rm -f /etc/modules-load.d/eos-webcam.conf
sudo rm -f /etc/udev/rules.d/70-eos-webcam.conf
sudo udevadm control --reload-rules

info "Unloading v4l2loopback module..."
sudo modprobe -r v4l2loopback 2>/dev/null || true

info "Done. v4l2loopback will not load on next boot."
