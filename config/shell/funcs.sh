#
# Shell functions I use.
#

# Grab the coverage profile for a go project.
cover () { 
    t="/tmp/go-cover.$$.tmp"
    go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}
