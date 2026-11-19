// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "glsdk",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
    ],
    products: [
        .library(name: "GreenlightSDK", targets: ["glsdkFFI", "GreenlightSDK"]),
    ],
    targets: [
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.5.0/glsdkFFI.xcframework.zip", checksum: "17929f048753cc93d4e98efb26a24c11e51823e3abe3ca9f0ab0fbbacae9bad0"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
