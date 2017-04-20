#!/usr/bin/env bash
# This script is for displaying hidden applications on startup

sudo sed -i "s/NoDisplay=true/NoDisplay=false/g" /etc/xdg/autostart/*.desktop
