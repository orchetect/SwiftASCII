# SwiftASCII

<p>
<a href="https://developer.apple.com/swift">
<img src="https://img.shields.io/badge/Swift%205.3-compatible-orange.svg?style=flat"
	 alt="Swift 5.3 compatible" /></a>
<a href="#installation">
<img src="https://img.shields.io/badge/SPM-compatible-orange.svg?style=flat"
	 alt="Swift Package Manager (SPM) compatible" /></a>
<a href="https://developer.apple.com/swift">
<img src="https://img.shields.io/badge/platform-macOS%2010.12%20|%20iOS%209%20|%20tvOS%20|%20watchOS%20-green.svg?style=flat"
	 alt="Platform - macOS 10.11 | iOS 9 | tvOS | watchOS" /></a>
<a href="#contributions">
<img src="https://img.shields.io/badge/Linux-not%20tested-black.svg?style=flat"
	 alt="Linux - not tested" /></a>
<a href="https://github.com/orchetect/SwiftASCII/blob/main/LICENSE">
<img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat"
	 alt="License: MIT" /></a>

Type-safe `ASCIIString` and `ASCIICharacter` types for Swift.

Complete unit test coverage.

## Installation

### Swift Package Manager (SPM)

To add ASCIIString to your Xcode project:

1. Select File → Swift Packages → Add Package Dependency
2. Add package using  `https://github.com/orchetect/ASCIIString` as the URL.

## Getting Started

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