#!/usr/bin/env bash
echo "Updating flatpak packages..."
su amg -c "flatpak update -y"
