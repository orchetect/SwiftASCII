//
//  ASCIICharacter.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//

import Foundation

/// A type containing a Character instance that is guaranteed to conform to ASCII encoding.
public struct ASCIICharacter: Hashable {
    
    /// The ASCII character returned as a `Character`
    public let characterValue: Character
    
    /// The ASCII encoding value of this character
    public let asciiValue: UInt8
    
    /// The ASCII character encoded as raw Data
    public var rawData: Data {
        Data([asciiValue])
    }
    
    @inlinable public init?(exactly source: Character) {
        
        guard let getASCIIValue = source.asciiValue else {
            return nil
        }
        
        characterValue = source
        asciiValue = getASCIIValue
        
    }
    
    @inlinable public init(_ lossy: Character) {
        
        guard let getASCIIValue = lossy.asciiValue else {
            // if ASCII encoding fails, fall back to a default character instead of throwing an exception
            
            var translated = String(lossy).asciiStringLossy
            if translated.stringValue.isEmpty { translated = "?" }
            
            characterValue = Character(translated.stringValue)
            asciiValue = characterValue.asciiValue ?? 0x3F
            
            return
        }
        
        characterValue = lossy
        asciiValue = getASCIIValue
        
    }
    
    @inlinable public init?(exactly source: String) {
        
        guard source.count == 1,
              let char = source.first
        else { return nil }
        
        guard let getASCIIValue = char.asciiValue else {
            return nil
        }
        
        characterValue = char
        asciiValue = getASCIIValue
        
    }
    
    @inlinable public init(_ lossy: String) {
        
        let char: Character = lossy.first ?? "?"
        
        self.init(char)
        
    }
    
    @inlinable public init?(exactly source: Data) {
        
        guard source.count == 1 else { return nil }
        
        guard let string = String(data: source, encoding: .nonLossyASCII) else {
            return nil
        }
        
        guard let scalar = string.unicodeScalars.first else {
            return nil
        }
        
        characterValue = Character(scalar)
        asciiValue = UInt8(ascii: scalar)
        
    }
    
    @inlinable public init?<T: BinaryInteger>(_ asciiValue: T) {
        
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
        
        (32...126).contains(asciiValue)
            ? String(characterValue)
            : ""
        
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

extension ASCIICharacter {
    
    /// Convenience syntactic sugar
    public static func exactly(_ source: Character) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience syntactic sugar
    public static func lossy(_ source: Character) -> ASCIICharacter {
        Self(source)
    }
    
    /// Convenience syntactic sugar
    public static func exactly(_ source: String) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience syntactic sugar
    public static func lossy(_ source: String) -> ASCIICharacter {
        Self(source)
    }
    
    /// Convenience syntactic sugar
    public static func exactly(_ source: Data) -> ASCIICharacter? {
        Self(exactly: source)
    }
    
    /// Convenience syntactic sugar
    public static func exactly<T: BinaryInteger>(_ value: T) -> ASCIICharacter? {
        Self(value)
    }
    
}
