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
    public init?(exactly source: String) {
        
        guard source.allSatisfy({ $0.isASCII }),
              let asciiData = source.data(using: .ascii)
        else { return nil }
        
        self.stringValue = source
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
    public init(_ lossy: String) {
        
        guard lossy.allSatisfy({ $0.isASCII }),
              let asciiData = lossy.data(using: .ascii) else {
            
            // if ASCII encoding fails, fall back to a default string instead of throwing an exception
            
            self.stringValue = lossy.asciiStringLossy.stringValue
            self.rawData = stringValue.data(using: .ascii) ?? Data([])
            return
        }
        
        self.stringValue = lossy
        self.rawData = asciiData
        
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

extension ASCIIString {
    
    /// Convenience: initialize a `ASCIIString` instance.
    public static func exactly(_ source: String) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIIString` instance.
    public static func exactly(_ source: Data) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience: initialize a `ASCIIString` instance.
    public static func lossy(_ source: String) -> ASCIIString {
        Self(source)
    }
    
}
