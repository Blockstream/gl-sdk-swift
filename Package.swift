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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/202511-gl-sdk-swift/glsdkFFI.xcframework.zip", checksum: "013c65e14b676bcffdd383e81b3c5857f03c8b09b6bf53400613b6edfa5493e7"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
