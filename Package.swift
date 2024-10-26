// swift-tools-version:5.3
// (be sure to update the .swift-version file when this Swift version changes)

import PackageDescription

let package = Package(
    name: "SwiftASCII",
    platforms: [.macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(
            name: "SwiftASCII",
            targets: ["SwiftASCII"]
        )
    ],
    targets: [
        .target(
            name: "SwiftASCII",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftASCIITests",
            dependencies: ["SwiftASCII"]
        )
    ]
)
