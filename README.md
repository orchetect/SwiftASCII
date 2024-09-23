# SwiftASCII

[![CI Build Status](https://github.com/orchetect/SwiftASCII/actions/workflows/build.yml/badge.svg)](https://github.com/orchetect/SwiftASCII/actions/workflows/build.yml) [![Platforms - macOS 10.11+ | iOS 9+ | tvOS 9+ | watchOS 2+ | visionOS 1+](https://img.shields.io/badge/platforms-macOS%2010.11+%20|%20iOS%209+%20|%20tvOS%209+%20|%20watchOS%202+%20|%20visionOS%201+-lightgrey.svg?style=flat)](https://developer.apple.com/swift) ![Swift 5.3-6.0](https://img.shields.io/badge/Swift-5.3–6.0-orange.svg?style=flat) [![Xcode 13-16](https://img.shields.io/badge/Xcode-13–16-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/SwiftASCII/blob/main/LICENSE)

`ASCIIString` and `ASCIICharacter` types for Swift offering validation and lossy conversion from `String`.

Complete unit test coverage.

## Getting Started

### Swift Package Manager (SPM)

1. Add SwiftASCII as a dependency using Swift Package Manager.

   - In an app project or framework, in Xcode:

     - Select the menu: **File → Swift Packages → Add Package Dependency...**
     - Enter this URL: `https://github.com/orchetect/SwiftASCII`

   - In a Swift Package, add it to the Package.swift dependencies:

     ```swift
     .package(url: "https://github.com/orchetect/SwiftASCII", from: "1.1.0")
     ```

2. Import the library:

   ```swift
   import SwiftASCII
   ```

### ASCIIString

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

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/SwiftASCII/blob/master/LICENSE) for details.

## Contributions

Contributions are welcome. Feel free to post an Issue to discuss.
