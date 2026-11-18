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

Releases follow the Greenlight SDK: every `gl-sdk-vX.Y.Z` release of
[Blockstream/greenlight](https://github.com/blockstream/greenlight)
is published here as `X.Y.Z`.

1. greenlight's `swift.yml` workflow builds `glsdkFFI.xcframework.zip`
   and the Swift bindings `glsdk.swift` for the `gl-sdk-vX.Y.Z` tag,
   and attaches them to greenlight's `gl-sdk-vX.Y.Z` release.
2. This repository's `publish.yml` workflow runs every hour. For each
   such release that is not published here yet, it commits the bindings
   and a `Package.swift` whose binary target points at the zip in the
   greenlight release, tags `X.Y.Z` and creates the `X.Y.Z` release.
   It then downloads the zip the way SwiftPM does and checks it against
   the checksum in `Package.swift`.

To publish without waiting, or to retry, run `publish.yml` from the
Actions tab, optionally with a `version`. `dry_run` prepares the commit
and tag without pushing them. GitHub disables scheduled workflows in a
public repository after 60 days without activity: if releases stop
appearing, re-enable `publish.yml` on the Actions tab.
