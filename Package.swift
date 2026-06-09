// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "glsdk",
    platforms: [
        .macOS(.v12),
        .iOS(.v13),
    ],
    products: [
        .library(name: "GreenlightSDK", targets: ["glsdkFFI", "GreenlightSDK"]),
    ],
    targets: [
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.4.0/glsdkFFI.xcframework.zip", checksum: "c06d1adeaac1a9bc9b002d6e9949f45035bbe37917a53e132874794314c64354"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
