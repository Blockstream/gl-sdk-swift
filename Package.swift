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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.5.1/glsdkFFI.xcframework.zip", checksum: "4b92cdec717d992cd37ec75618a870b9ffc6276cb34f8b8f85009134404694a0"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
