#!/usr/bin/env bash
set -euo pipefail

case "$SCIFOR_RUNNER_OS" in
  Linux)
    sudo apt-get install -y gfortran pkg-config
    sudo apt-get install -y libopenmpi-dev libopenmpi3 openmpi-bin openmpi-common openmpi-doc
    sudo apt-get install -y libblas-dev liblapack-dev libopenblas-openmp-dev
    ;;
  macOS)
    brew reinstall gcc
    brew install openmpi pkg-config
    brew install lapack openblas scalapack
    ;;
  *)
    echo "Unsupported runner OS: $SCIFOR_RUNNER_OS" >&2
    exit 1
    ;;
esac
