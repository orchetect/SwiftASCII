//
//  ASCIIString.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//

import Foundation

/// ASCII String:
/// A type containing a `String` instance that is guaranteed to conform to ASCII encoding.
/// Offers a validating `exactly: String` failable initializer and a `_ lossy: String` conversion initializer.
public struct ASCIIString: Hashable {
    /// The ASCII string returned as a `String`
    public let stringValue: String
    
    /// The ASCII string encoded as raw Data
    public let rawData: Data
    
    /// Returns a new `ASCIIString` instance if the source string is an ASCII string verbatim.
    /// Returns `nil` if the source string contains any non-ASCII characters.
    @inlinable
    public init?<S: StringProtocol>(exactly source: S) {
        guard source.allSatisfy({ $0.isASCII }),
              let asciiData = source.data(using: .ascii)
        else { return nil }
        
        self.stringValue = String(source)
        self.rawData = asciiData
    }
    
    /// Returns a new `ASCIIString` instance if the source data contains an ASCII string verbatim.
    /// Returns `nil` if the source data contains any non-ASCII character bytes.
    @inlinable
    public init?(exactly source: Data) {
        guard let string = String(data: source, encoding: .nonLossyASCII),
              string.allSatisfy({ $0.isASCII })
        else { return nil }
        
        self.stringValue = string
        self.rawData = source
    }
    
    /// Returns a new `ASCIIString` instance from the source string, removing or converting any non-ASCII characters if necessary.
    @inlinable
    public init<S: StringProtocol>(_ lossy: S) {
        guard lossy.allSatisfy({ $0.isASCII }),
              let asciiData = lossy.data(using: .ascii)
        else {
            // if ASCII encoding fails, fall back to a default string instead of throwing an exception
            
            self.stringValue = lossy.asciiStringLossy.stringValue
            self.rawData = stringValue.data(using: .ascii) ?? Data([])
            return
        }
        
        self.stringValue = String(lossy)
        self.rawData = asciiData
    }
    
    /// Returns a new `ASCIIString` instance from a `ASCIICharacter` sequence.
    @inlinable
    public init<S>(_ characters: S)
    where S: Sequence, S.Element == ASCIICharacter
    {
        self.stringValue = String(characters.map { $0.characterValue })
        self.rawData = Data(characters.map { $0.asciiValue })
    }
    
    /// Returns a new `ASCIIString` instance by concatenating a `ASCIIString` sequence.
    @inlinable
    public init<S>(_ substrings: S)
    where S: Sequence, S.Element == ASCIIString
    {
        self.stringValue = substrings.map { $0.stringValue }.joined()
        self.rawData = Data(substrings.map { $0.rawData }.joined())
    }
    
    /// Returns a new `ASCIIString` instance from an `ASCIICharacter`.
    @inlinable
    public init(_ character: ASCIICharacter) {
        self.stringValue = "\(character.characterValue)"
        self.rawData = character.rawData
    }
}

extension ASCIIString: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    @inlinable
    public init(stringLiteral: String) {
        self.init(stringLiteral)
    }
}

extension ASCIIString: CustomStringConvertible {
    public var description: String {
        stringValue
    }
}

extension ASCIIString: CustomDebugStringConvertible {
    public var debugDescription: String {
        "ASCIIString(\"\(stringValue)\")"
    }
}

extension ASCIIString: LosslessStringConvertible {
    // required init already implemented above
}

extension ASCIIString: Equatable {
    public static func == <T: StringProtocol>(lhs: Self, rhs: T) -> Bool {
        lhs.stringValue == rhs
    }
    
    public static func != <T: StringProtocol>(lhs: Self, rhs: T) -> Bool {
        lhs.stringValue != rhs
    }
    
    public static func == <T: StringProtocol>(lhs: T, rhs: Self) -> Bool {
        lhs == rhs.stringValue
    }
    
    public static func != <T: StringProtocol>(lhs: T, rhs: Self) -> Bool {
        lhs != rhs.stringValue
    }
}

extension ASCIIString: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let newInstance = Self(exactly: stringValue) else {
            throw DecodingError.dataCorrupted(
                .init(
                    codingPath: container.codingPath,
                    debugDescription: "Encoded string is not a valid ASCII string."
                )
            )
        }
        self = newInstance
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(stringValue)
    }
}

extension ASCIIString {
    public static func + (lhs: ASCIIString, rhs: ASCIIString) -> ASCIIString {
        ASCIIString([lhs, rhs])
    }
}

extension ASCIIString {
    /// Convenience: initialize a `ASCIIString` instance.
    public static func exactly<S: StringProtocol>(_ source: S) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIIString` instance.
    public static func exactly(_ source: Data) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIIString` instance.
    public static func lossy<S: StringProtocol>(_ source: S) -> ASCIIString {
        Self(source)
    }
}

extension Sequence where Element == ASCIIString {
    /// Returns a new string by concatenating the elements of the sequence.
    @_disfavoredOverload
    public func joined() -> ASCIIString {
        let joinedStr = map { $0.stringValue }.joined()
        let joinedData = Data(map { $0.rawData }.joined())
        return ASCIIString(guaranteedASCII: joinedStr,
                           rawData: joinedData)
    }
    
    /// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element.
    @_disfavoredOverload
    public func joined(separator: ASCIIString) -> ASCIIString {
        let joinedStr = map { $0.stringValue }
            .joined(separator: separator.stringValue)
        let joinedData = Data(map { $0.rawData }
            .joined(separator: separator.rawData))
        return ASCIIString(guaranteedASCII: joinedStr,
                           rawData: joinedData)
    }
}

// MARK: - Internal Utility

extension ASCIIString {
    /// Internal use only.
    /// Used when string and data are already known to be valid ASCII.
    internal init(guaranteedASCII string: String, rawData: Data) {
        self.stringValue = string
        self.rawData = rawData
    }
}
