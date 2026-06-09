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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.4.1/glsdkFFI.xcframework.zip", checksum: "4ef7ed808afa8bd73561f2b94ed64689b78e3998d817cfe09d378914bc312380"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
