#!/bin/sh
#
# Shell functions I use.
#

# Grab the coverage profile for a go project.
cover () { 
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

# Connect to a pulse secure VPN via openconnect
openconnect_vpn() {
    sudo openconnect --juniper -C "DSID=$1" vpn.sonifi.com -b    
}

kill_openconnect() {
    sudo killall -SIGINT openconnect
}
