# SwiftASCII

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-ascii%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/orchetect/swift-ascii) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-ascii%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/orchetect/swift-ascii) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/swift-ascii/blob/main/LICENSE)

Introduces `ASCIIString` and `ASCIICharacter` types for Swift offering validation and lossy conversion from `String`.

Complete unit test coverage.

## Installation

### Swift Package Manager (SPM)

To add this package to an Xcode app project, use:

 `https://github.com/orchetect/swift-ascii` as the URL.

To add this package to a Swift package, add the dependency to your package and target in Package.swift:

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-ascii", from: "1.3.2")
    ],
    targets: [
        .target(
            dependencies: [
                .product(name: "SwiftASCII", package: "swift-ascii")
            ]
        )
    ]
)
```

## ASCIIString

```swift
// failable init
ASCIIString(exactly: "An ASCII String.") // succeeds
ASCIIString(exactly: "Ãñ ÂŚÇÏÎ Strïńg.") // nil

// lossy string conversion making ASCII-compatible substitutions
ASCIIString("An ASCII String.") // "An ASCII String." (unchanged)
ASCIIString("Ãñ ÂŚÇÏÎ Strïńg.") // "An ASCII String." (substituted)

// lossy string conversion through String literal type inference
let str: ASCIIString = "Ãñ ÂŚÇÏÎ Strïńg."
print(str) // "An ASCII String." (substituted)
```

```swift
let asciiString = ASCIIString("ÂŚÇÏÎ")

// returns typed as String
asciiString.stringValue // "ASCII"

// returns Data representation of string
asciiString.rawData // Data([0x41, 0x53, 0x43, 0x49, 0x49])
```

### ASCIICharacter

```swift
// failable init
ASCIICharacter(exactly: "A") // succeeds
ASCIICharacter(exactly: "Ω") // nil

// lossy string conversion making ASCII-compatible substitutions
ASCIICharacter("A") // "A" (unchanged)
ASCIICharacter("Ã") // "A" (substituted)

// lossy character conversion through Character literal type inference
let char: ASCIICharacter = "Ä"
print(char) // "A" (substituted)

// failable ASCII integer literal init
ASCIICharacter(65) // "A"
ASCIICharacter(300) // nil
```

```swift
let asciiString = ASCIICharacter("Ä")

// returns typed as Character
asciiString.characterValue // Character("A")

// returns ASCII integer literal
asciiString.asciiValue // 65

// returns Data representation of character
asciiString.rawData // Data([0x41])
```

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/swift-ascii/blob/master/LICENSE) for details.

## Community & Support

Please do not email maintainers for technical support. Several options are available for issues and questions:

- Questions and feature ideas can be posted to [Discussions](https://github.com/orchetect/swift-ascii/discussions).
- If an issue is a verifiable bug with reproducible steps it may be posted in [Issues](https://github.com/orchetect/swift-ascii/issues).

## Contributions

Contributions are welcome. Posting in [Discussions](https://github.com/orchetect/swift-ascii/discussions) first prior to new submitting PRs for features or modifications is encouraged.

## Code Quality & AI Contribution Policy

In an effort to maintain a consistent level of code quality and safety, this repository was built by hand and is maintained without the use of AI code generation.

AI-assisted contributions are welcome, but must remain modest in scope, maintain the same degree of quality and care, and be thoroughly vetted before acceptance.

## Legacy

This repository was formerly known as SwiftASCII.
