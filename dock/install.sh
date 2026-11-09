#!/bin/sh
# Run with sudo: installs the root part (udev rule + retrain script) and
# symlinks the user scripts from this repo into the invoking user's ~/.local/bin.
set -e
DOCK_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -ne 0 ]; then
  echo "run with sudo" >&2
  exit 1
fi

# root part
install -m 755 "$DOCK_DIR/dock-dp-retrain" /usr/local/sbin/dock-dp-retrain
install -m 644 "$DOCK_DIR/99-dock-dp-retrain.rules" /etc/udev/rules.d/99-dock-dp-retrain.rules
udevadm control --reload
echo "installed /usr/local/sbin/dock-dp-retrain and udev rule"

# user part: symlinks owned by the user who ran sudo
U="${SUDO_USER:?run via sudo from your user account}"
H="$(getent passwd "$U" | cut -d: -f6)"
install -d -o "$U" -g "$(id -gn "$U")" "$H/.local/bin"
for src in "$DOCK_DIR/dphotplug"; do
  f="$(basename "$src")"
  ln -sfn "$src" "$H/.local/bin/$f"
  chown -h "$U:$(id -gn "$U")" "$H/.local/bin/$f"
  echo "linked $H/.local/bin/$f -> $src"
done
