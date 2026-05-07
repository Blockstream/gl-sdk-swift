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
        .binaryTarget(name: "glsdkFFI", url: "https://github.com/Blockstream/gl-sdk-swift/releases/download/0.2.1/glsdkFFI.xcframework.zip", checksum: "51b36c36799c48b002ea110aae066f35695d84053217668e0d0b2f59bcf4eb53"),
        .target(name: "GreenlightSDK", dependencies: ["glsdkFFI"]),
    ]
)
