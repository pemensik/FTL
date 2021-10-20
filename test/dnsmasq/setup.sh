#!/bin/bash

MYDIR="$(dirname -- "$0")"

run_server() {
	local CONF="$1"
	local PIDF="$2"

	[ -r $PIDF ] && pkill -F $PIDF
	dnsmasq --conf-file="$CONF" --pid-file=$PIDF
}

echo "********* Starting dnsmasq **********"

# Start services
run_server $MYDIR/auth.conf /run/dnsmasq-auth.pid

# Have to create the socketdir or the recursor will fails to start
run_server $MYDIR/recursor.conf /run/dnsmasq-forward.pid
