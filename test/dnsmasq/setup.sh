#!/bin/bash

MYDIR="$(dirname -- "$0")"
: ${DNSMASQ:=dnsmasq}

run_server() {
	local CONF="$1"
	local PIDF="$2"

	[ -r $PIDF ] && pkill -F $PIDF
	"$DNSMASQ" --conf-file="$CONF" --pid-file=$PIDF
}

echo "********* Starting dnsmasq **********"

# Start services
run_server $MYDIR/auth.conf /run/dnsmasq-auth.pid

# Have to create the socketdir or the recursor will fails to start
run_server $MYDIR/recursor.conf /run/dnsmasq-forward.pid
