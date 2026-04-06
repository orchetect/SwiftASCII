// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-ascii",
    platforms: [.macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "SwiftASCII", targets: ["SwiftASCII"])
    ],
    targets: [
        .target(name: "SwiftASCII"),
        .testTarget(name: "SwiftASCIITests", dependencies: ["SwiftASCII"])
    ]
)
