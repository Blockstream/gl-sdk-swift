#!/usr/bin/env bash
# Compiles the package in this checkout for the iOS simulator against a
# local XCFramework zip instead of the one Package.swift downloads. Run
# it after scripts/prepare.sh, on macOS with Xcode.
#
#   scripts/check-package.sh <glsdkFFI.xcframework.zip>
set -euo pipefail
ZIP=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
cd "$(dirname "$0")/.."
PKG=$(mktemp -d)/GreenlightSDK
mkdir -p "$PKG"
cp -R Package.swift Sources "$PKG"/
(cd "$PKG" && unzip -q "$ZIP")
# The binary target is the only one with a url, point it at the local copy.
sed -E -i '' 's|url: "[^"]*", checksum: "[^"]*"|path: "glsdkFFI.xcframework"|' "$PKG/Package.swift"
grep -q 'path: "glsdkFFI.xcframework"' "$PKG/Package.swift" || {
  echo "::error::Package.swift has no binary target with a url"; exit 1; }
cd "$PKG"
# Xcode names the schemes after the package's products; build the
# library's, or the whole package's.
SCHEMES=$(xcodebuild -list -json | jq -r '(.workspace // .project).schemes[]')
echo "Schemes: $(echo $SCHEMES)"
SCHEME=$(grep -xE 'GreenlightSDK|glsdk-Package|glsdk' <<<"$SCHEMES" | head -n1)
[ -n "$SCHEME" ] || { echo "::error::No GreenlightSDK or glsdk scheme in the package"; exit 1; }
xcodebuild build -scheme "$SCHEME" -destination 'generic/platform=iOS Simulator' -quiet
echo "The package compiles against $ZIP"
