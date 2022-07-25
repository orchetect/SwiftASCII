//
//  ASCIICharacter.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//

import Foundation

/// ASCII Character:
/// A type containing a `Character` instance that is guaranteed to conform to ASCII encoding.
/// Offers a validating `exactly: Character` failable initializer and a `_ lossy: Character` conversion initializer.
public struct ASCIICharacter: Hashable {
    /// The ASCII character returned as a `Character`
    public let characterValue: Character
    
    /// The ASCII encoding value of this character
    public let asciiValue: UInt8
    
    /// The ASCII character encoded as raw Data
    public var rawData: Data {
        Data([asciiValue])
    }
    
    /// Returns a new `ASCIICharacter` instance if the source character is a valid ASCII character.
    @inlinable
    public init?(exactly source: Character) {
        guard let getASCIIValue = source.asciiValue else {
            return nil
        }
        
        self.characterValue = source
        self.asciiValue = getASCIIValue
    }
    
    /// Returns a new `ASCIICharacter` instance from the source character, converting a non-ASCII character to its closest ASCII equivalent if necessary.
    @inlinable
    public init(_ lossy: Character) {
        guard let getASCIIValue = lossy.asciiValue else {
            // if ASCII encoding fails, fall back to a default character instead of throwing an exception
            
            var translated = String(lossy).asciiStringLossy
            if translated.stringValue.isEmpty { translated = "?" }
            
            self.characterValue = Character(translated.stringValue)
            self.asciiValue = characterValue.asciiValue ?? 0x3F
            
            return
        }
        
        self.characterValue = lossy
        self.asciiValue = getASCIIValue
    }
    
    /// Returns a new `ASCIICharacter` instance if the source string contains a single character and the character is a valid ASCII character.
    @_disfavoredOverload
    @inlinable
    public init?<S: StringProtocol>(exactly source: S) {
        guard source.count == 1,
              let char = source.first
        else { return nil }
        
        guard let getASCIIValue = char.asciiValue else {
            return nil
        }
        
        self.characterValue = char
        self.asciiValue = getASCIIValue
    }
    
    /// Returns a new `ASCIICharacter` instance if the source string contains a single character, converting a non-ASCII character to its closest ASCII equivalent if necessary.
    @inlinable
    public init<S: StringProtocol>(_ lossy: S) {
        let char: Character = lossy.first ?? "?"
        
        self.init(char)
    }
    
    /// Returns a new `ASCIICharacter` instance if the source data is a single ASCII character.
    /// Returns `nil` if the source data is not a single byte or if it contains a non-ASCII character byte.
    @inlinable
    public init?(exactly source: Data) {
        guard source.count == 1 else { return nil }
        
        guard let string = String(data: source, encoding: .nonLossyASCII) else {
            return nil
        }
        
        guard let scalar = string.unicodeScalars.first else {
            return nil
        }
        
        self.characterValue = Character(scalar)
        self.asciiValue = UInt8(ascii: scalar)
    }
    
    /// Returns a new `ASCIICharacter` instance from an ASCII character number.
    /// Returns `nil` if the number is not within the valid ASCII table (0..<128).
    @inlinable
    public init?<T: BinaryInteger>(_ asciiValue: T) {
        guard let getASCIIValue = UInt8(exactly: asciiValue) else { return nil }
        
        self.init(exactly: Data([getASCIIValue]))
    }
}

extension ASCIICharacter: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = Character
    
    public init(extendedGraphemeClusterLiteral value: Character) {
        self.init(value)
    }
}

extension ASCIICharacter: CustomStringConvertible {
    public var description: String {
        // If not a printable character, return an empty string and don't allow any non-printable ASCII control characters through
        
        (32 ... 126).contains(asciiValue)
            ? String(characterValue)
            : "?"
    }
}

extension ASCIICharacter: CustomDebugStringConvertible {
    public var debugDescription: String {
        "ASCIICharacter(#\(asciiValue): \"" + description + "\")"
    }
}

extension ASCIICharacter: Equatable {
    // Self & Self
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.asciiValue == rhs.asciiValue
    }
    
    public static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.asciiValue != rhs.asciiValue
    }
    
    // Self, Character
    
    public static func == (lhs: Self, rhs: Character) -> Bool {
        lhs.characterValue == rhs
    }
    
    public static func != (lhs: Self, rhs: Character) -> Bool {
        lhs.characterValue != rhs
    }
    
    // Character, Self
    
    public static func == (lhs: Character, rhs: Self) -> Bool {
        lhs == rhs.characterValue
    }
    
    public static func != (lhs: Character, rhs: Self) -> Bool {
        lhs != rhs.characterValue
    }
}

extension ASCIICharacter: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let newInstance = Self(exactly: string) else {
            throw DecodingError.dataCorrupted(
                .init(
                    codingPath: container.codingPath,
                    debugDescription: "Value was not valid ASCII character number."
                )
            )
        }
        self = newInstance
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        try container.encode(String(characterValue))
    }
}

extension ASCIICharacter {
    public static func + (lhs: ASCIICharacter, rhs: ASCIICharacter) -> ASCIIString {
        ASCIIString([lhs, rhs])
    }
    
    public static func + (lhs: ASCIICharacter, rhs: ASCIIString) -> ASCIIString {
        ASCIIString(lhs) + rhs
    }
    
    public static func + (lhs: ASCIIString, rhs: ASCIICharacter) -> ASCIIString {
        lhs + ASCIIString(rhs)
    }
}

extension ASCIICharacter {
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func exactly(_ source: Character) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func lossy(_ source: Character) -> ASCIICharacter {
        Self(source)
    }
    
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func exactly<S: StringProtocol>(_ source: S) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func lossy<S: StringProtocol>(_ source: S) -> ASCIICharacter {
        Self(source)
    }
    
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func exactly(_ source: Data) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIICharacter` instance.
    public static func exactly<T: BinaryInteger>(_ value: T) -> ASCIICharacter? {
        Self(value)
    }
}

extension Sequence where Element == ASCIICharacter {
    /// Returns a new string by concatenating the elements of the sequence.
    public func joined() -> ASCIIString {
        ASCIIString(self)
    }
    
    /// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element.
    public func joined(separator: ASCIIString) -> ASCIIString {
        let joinedStr = map { "\($0.characterValue)" }
            .joined(separator: separator.stringValue)
        let joinedData = Data(
            map { $0.rawData }
                .joined(separator: separator.rawData)
        )
        return ASCIIString(
            guaranteedASCII: joinedStr,
            rawData: joinedData
        )
    }
}
