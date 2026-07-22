#!/bin/sh

set -eu

target=${1:-}

case "$target" in
  setup | build | file | clean)
    ;;
  *)
    echo "usage: $0 {setup|build|file|clean}" >&2
    exit 2
    ;;
esac

lean_file=${LEAN_FILE:-}

if [ "$target" = "file" ]; then
  case "$lean_file" in
    *"/../"* | *"/./"* | ../* | ./* | */.. | */.)
      echo "LEAN_FILE must not contain parent or current-directory traversal" >&2
      exit 2
      ;;
    NonlinearDynamics/*.lean)
      ;;
    *)
      echo "LEAN_FILE must be a .lean path beneath formalization/NonlinearDynamics" >&2
      exit 2
      ;;
  esac
fi

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

"$script_dir/require_cloud_lean_build.sh"

cd "$script_dir/../formalization"

if [ "$target" = "file" ]; then
  formalization_root=$(pwd -P)
  lean_file=$(realpath --canonicalize-existing -- "$lean_file")
  case "$lean_file" in
    "$formalization_root"/NonlinearDynamics/*.lean)
      ;;
    *)
      echo "LEAN_FILE resolves outside formalization/NonlinearDynamics" >&2
      exit 2
      ;;
  esac
fi

# The approved builder installs Elan in its standard per-user location.
# shellcheck disable=SC1091
. "$HOME/.elan/env"

case "$target" in
  setup)
    sha256sum --check lake-manifest.sha256
    lake update
    sha256sum --check lake-manifest.sha256
    lake exe cache get
    ;;
  build)
    sha256sum --check lake-manifest.sha256
    lake build
    ;;
  file)
    sha256sum --check lake-manifest.sha256
    lake env lean -DwarningAsError=true "$lean_file"
    ;;
  clean)
    lake clean
    ;;
esac
