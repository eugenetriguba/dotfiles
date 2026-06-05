set -gx GOPATH $SRC_DIR/go
set -gx GOBIN $GOPATH/bin
set -gx GOPROXY direct

fish_add_path $GOBIN
