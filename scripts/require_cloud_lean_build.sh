#!/bin/sh

set -eu

host_os=$(uname -s)

if [ "$host_os" != "Linux" ]; then
  cat >&2 <<'EOF'
Lean and Mathlib builds are disabled on this workstation.

This project builds Lean only on explicitly approved Linux cloud compute.
Do not restore or regenerate the macOS Mathlib cache. For non-Lean validation
here, use `make workstation-check` or the individual Hugo/checkpoint targets.
EOF
  exit 1
fi

if [ "${CLOUD_LEAN_BUILD:-0}" != "1" ]; then
  cat >&2 <<'EOF'
Refusing to run a Lean/Mathlib build without an explicit cloud acknowledgement.

After the Linux cloud resource has human approval, run the target with
`CLOUD_LEAN_BUILD=1`, for example:

  CLOUD_LEAN_BUILD=1 make check
EOF
  exit 1
fi
