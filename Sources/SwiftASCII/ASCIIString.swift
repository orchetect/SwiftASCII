//
//  ASCIIString.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//

import Foundation

/// A type containing a String instance that is guaranteed to conform to ASCII encoding.
public struct ASCIIString: Hashable {
    
    /// The ASCII string returned as a `String`
    public let stringValue: String
    
    /// The ASCII string encoded as raw Data
    public let rawData: Data
    
    @inlinable public init?(exactly source: String) {
        
        guard source.allSatisfy({ $0.isASCII }),
              let asciiData = source.data(using: .ascii)
        else { return nil }
        
        stringValue = source
        rawData = asciiData
        
    }
    
    @inlinable public init?(exactly source: Data) {
        
        guard let string = String(data: source, encoding: .nonLossyASCII),
              string.allSatisfy({ $0.isASCII })
        else { return nil }
        
        stringValue = string
        rawData = source
        
    }
    
    @inlinable public init(_ lossy: String) {
        
        guard lossy.allSatisfy({ $0.isASCII }),
              let asciiData = lossy.data(using: .ascii) else {
            
            // if ASCII encoding fails, fall back to a default string instead of throwing an exception
            
            stringValue = lossy.asciiStringLossy.stringValue
            rawData = stringValue.data(using: .ascii) ?? Data([])
            return
        }
        
        stringValue = lossy
        rawData = asciiData
        
    }
    
}

extension ASCIIString: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    @inlinable public init(stringLiteral: String) {
        
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
    
    /// Convenience syntactic sugar
    public static func exactly(_ source: String) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience syntactic sugar
    public static func exactly(_ source: Data) -> ASCIIString? {
        Self(exactly: source)
    }
    
    /// Convenience syntactic sugar
    public static func lossy(_ source: String) -> ASCIIString {
        Self(source)
    }
    
}
