#!/usr/bin/env bash
set -oue pipefail

CONF_DIR="/etc/fonts/conf.d"

# if the symlink below isn't there then symlink from /usr/share
if [ ! -L "$CONF_DIR/11-lcdfilter-default.conf" ]; then
  ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
fi

if [ ! -L "$CONF_DIR/10-sub-pixel-rgb.conf" ]; then
  ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
fi
