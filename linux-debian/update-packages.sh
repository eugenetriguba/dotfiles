#!/bin/sh
set -e

main() {
  sudo apt-mark minimize-manual
  sudo apt-mark showmanual >packages.txt
}

main
