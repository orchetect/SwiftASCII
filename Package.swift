// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	
    name: "SwiftASCII",
	
	platforms: [.macOS(.v10_11), .iOS(.v9)],
	
    products: [
        
        .library(
            name: "SwiftASCII",
            targets: ["SwiftASCII"])
		
    ],
	
    dependencies: [
        // none
    ],
	
    targets: [
        
        .target(
            name: "SwiftASCII",
            dependencies: []),
        .testTarget(
            name: "SwiftASCIITests",
            dependencies: ["SwiftASCII"])
		
    ]
	
)
