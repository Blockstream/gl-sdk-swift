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
