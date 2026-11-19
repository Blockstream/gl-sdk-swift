# Greenlight SDK Swift Bindings

The [Greenlight SDK](https://github.com/blockstream/greenlight)
enables mobile developers to integrate a non-custodial hosted wallet
into their apps with a very shallow learning curve. More information
can be found here:
[blockstream/greenlight](https://github.com/blockstream/greenlight)

This repository maintains the Blockstream gl-sdk's official
[Swift](https://www.swift.org/) bindings.

## 👨‍🔧 Installation

We support integration via the [Swift Package Manager](https://www.swift.org/package-manager/).

### Swift Package Manager

#### Installation via Xcode

Via `File > Add Packages...`, add

```
https://github.com/blockstream/gl-sdk-swift.git
```

as a package dependency in Xcode.

#### Installation via Swift Package Manifest

Add the following to the dependencies array of your `Package.swift`:

``` swift
.package(url: "https://github.com/blockstream/gl-sdk-swift.git", from: "0.1.0"),
```

.

## 🚀 Releasing

Releases follow the Greenlight SDK and are started from
[Blockstream/greenlight](https://github.com/blockstream/greenlight):
Actions > Release > Run workflow. Every `gl-sdk-vX.Y.Z` release there is
published here as `X.Y.Z`.

1. greenlight's `swift.yml` builds `glsdkFFI.xcframework.zip` and the
   Swift bindings `glsdk.swift`, and attaches them to greenlight's
   `gl-sdk-vX.Y.Z` release.
2. This repository's `publish.yml` runs every hour. For each such
   release not published here yet, `scripts/prepare.sh` commits the
   bindings and a `Package.swift` whose binary target points at the zip
   in the greenlight release, and tags `X.Y.Z`. `publish.yml` pushes
   them, creates the `X.Y.Z` release, and `scripts/verify.sh` downloads
   the zip the way SwiftPM does and checks it against the checksum.
3. greenlight's release run waits for the `X.Y.Z` tag here and runs
   `scripts/verify.sh` itself, so the release shows on greenlight's
   Actions page whether or not it reached this repository.

greenlight's dry runs check out this repository's `main` and run
`scripts/prepare.sh` and `scripts/check-package.sh` against the fresh
build, without pushing anything, so the templates and scripts here are
tested by every greenlight build of the SDK.

To publish without waiting, or to retry, run `publish.yml` from the
Actions tab, optionally with a `version`. `dry_run` prepares the commit
and tag without pushing them. GitHub disables scheduled workflows in a
public repository after 60 days without activity: if releases stop
appearing, re-enable `publish.yml` on the Actions tab.
