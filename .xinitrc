#!/bin/bash
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY
exec i3
