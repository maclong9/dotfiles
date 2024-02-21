#!/bin/sh
if [ "$(uname -s)" = "Darwin" ]; then
  sudo port selfupdate
  sudo port upgrade outdated
  sudo port uninstall inactive
  sudo port uninstall rleaves
else
    echo "Running on unsupported system, exiting"
    exit 1
fi
