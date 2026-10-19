#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-inline-bash.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-inline-bash" ;;
    *) rel="x86_64-apple-darwin/gray-inline-bash" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-inline-bash" ;;
    *) rel="x86_64-unknown-linux-musl/gray-inline-bash" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-inline-bash.exe" "$here/target/release/gray-inline-bash" "$here/target/debug/gray-inline-bash.exe" "$here/target/debug/gray-inline-bash"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-inline-bash binary not found in $here" >&2
exit 1
