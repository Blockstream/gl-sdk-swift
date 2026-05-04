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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/2026w17-gl-sdk-0.2.1/glsdkFFI.xcframework.zip", checksum: "1e13a298b313008d7904a7e209e5ebf96cafefc467f1c8a396e0e9a54966f3e8"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
