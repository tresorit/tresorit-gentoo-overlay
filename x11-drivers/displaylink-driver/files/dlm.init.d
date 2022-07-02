#!/sbin/openrc-run
# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

name="DisplayLink Manager"
description="Driver for modern DisplayLink devices"
dir="/opt/@P@"

start() {
	modprobe -q evdi
	start-stop-daemon --start --background --chdir /opt/displaylink --make-pidfile --pidfile /run/dlm.pid --exec /opt/displaylink/DisplayLinkManager
	eend $?
}

stop() {
	start-stop-daemon --stop --pidfile /run/dlm.pid
	eend $?
}
