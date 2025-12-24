#!/bin/bash

# 1. Ensure the group exists
if ! getent group plugdev > /dev/null; then
    groupadd -r plugdev
fi

# 2. Get the actual human user (usually UID 1000)
# We avoid adding system users like 'root' or 'gdm'
PRIMARY_USER=$(bin/logname 2>/dev/null || who | awk '{print $1}' | head -n1)

if [ -n "$PRIMARY_USER" ] && [ "$PRIMARY_USER" != "root" ]; then
    usermod -aG plugdev "$PRIMARY_USER"
fi
