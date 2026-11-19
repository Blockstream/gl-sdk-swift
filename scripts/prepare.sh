#!/usr/bin/env bash
# Prepares the X.Y.Z release of the package in this checkout: checks the
# assets, renders Package.swift and the podspecs from templates/, copies
# the bindings, and commits and tags X.Y.Z locally. It pushes nothing.
#
#   scripts/prepare.sh <version> <asset dir> <zip url>
#
# The asset dir holds what greenlight's swift.yml builds:
# glsdkFFI.xcframework.zip, glsdkFFI.xcframework.zip.checksum and
# glsdk.swift. publish.yml runs this before pushing. greenlight's
# swift.yml runs it in every build, against a checkout of main, so a
# template that does not fit the build fails there first.
set -euo pipefail
cd "$(dirname "$0")/.."
VERSION=$1 DIR=$2 XCF_URL=$3

for f in glsdkFFI.xcframework.zip glsdkFFI.xcframework.zip.checksum glsdk.swift; do
  [ -s "$DIR/$f" ] || { echo "::error::$DIR/$f is missing or empty"; exit 1; }
done
if git rev-parse -q --verify "refs/tags/$VERSION" >/dev/null; then
  echo "::error::$VERSION is already tagged"
  exit 1
fi

# SwiftPM checks the zip against the SHA-256 in Package.swift.
XCF_CHECKSUM=$( (sha256sum "$DIR/glsdkFFI.xcframework.zip" 2>/dev/null || shasum -a 256 "$DIR/glsdkFFI.xcframework.zip") | cut -d' ' -f1)
if [ "$XCF_CHECKSUM" != "$(tr -d '[:space:]' < "$DIR/glsdkFFI.xcframework.zip.checksum")" ]; then
  echo "::error::glsdkFFI.xcframework.zip does not match its checksum file"
  exit 1
fi

export VERSION XCF_URL XCF_CHECKSUM
for f in Package.swift glsdkFFI.podspec GreenlightSDK.podspec; do
  envsubst '${VERSION} ${XCF_URL} ${XCF_CHECKSUM}' < "templates/$f" > "$f"
done
cp "$DIR/glsdk.swift" Sources/GreenlightSDK/GreenlightSDK.swift
if grep -q '\${' Package.swift glsdkFFI.podspec GreenlightSDK.podspec; then
  echo "::error::A template variable was left unset"
  grep -n '\${' Package.swift glsdkFFI.podspec GreenlightSDK.podspec
  exit 1
fi

git add Package.swift glsdkFFI.podspec GreenlightSDK.podspec Sources
git commit -q -m "Bump Greenlight SDK to version $VERSION" \
  -m "Built from https://github.com/Blockstream/greenlight/releases/tag/gl-sdk-v$VERSION"
git tag -a "$VERSION" -m "$VERSION"
git show --stat HEAD
