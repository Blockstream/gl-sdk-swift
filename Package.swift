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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.12.0/glsdkFFI.xcframework.zip", checksum: "f997682795fb4619afdfdc11e98b7b3b8a39592db8b9d56159daceaeb40e744a"),
        .target(name: "LiquidWalletKit", dependencies: ["lwkFFI"]),
    ]
)