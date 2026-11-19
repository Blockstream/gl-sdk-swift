#!/usr/bin/env bash
# Checks a published version the way SwiftPM installs it: fetch
# Package.swift at the X.Y.Z tag on GitHub, download its binary target
# and compare it with the checksum. Needs nothing but curl.
#
#   scripts/verify.sh <version>
set -euo pipefail
VERSION=$1
# raw.githubusercontent.com can lag behind a tag that was just pushed.
for i in $(seq 1 10); do
  PACKAGE=$(curl -fsSL "https://raw.githubusercontent.com/Blockstream/gl-sdk-swift/refs/tags/$VERSION/Package.swift") && break
  [ "$i" = 10 ] && { echo "::error::No Package.swift at tag $VERSION"; exit 1; }
  sleep 30
done
URL=$(sed -nE 's/.*url: "([^"]+)".*/\1/p' <<<"$PACKAGE")
EXPECTED=$(sed -nE 's/.*checksum: "([0-9a-f]{64})".*/\1/p' <<<"$PACKAGE")
[ -n "$URL" ] && [ -n "$EXPECTED" ] || { echo "::error::$VERSION: no binary target url and checksum in Package.swift"; exit 1; }
ACTUAL=$(curl -fsSL "$URL" | (sha256sum 2>/dev/null || shasum -a 256) | cut -d' ' -f1)
if [ "$EXPECTED" != "$ACTUAL" ]; then
  echo "::error::$VERSION: Package.swift expects $EXPECTED, $URL is $ACTUAL"
  exit 1
fi
echo "$VERSION verified: $URL ($ACTUAL)"
