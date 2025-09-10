//
//  String.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2021-2024 Steffan Andrews • Licensed under MIT License
//

import Foundation

// MARK: - Inits

extension StringProtocol where Self == String {
    /// Initialize from an `ASCIIString` instance.
    @inlinable
    public init(_ asciiString: ASCIIString) {
        self = asciiString.stringValue
    }
}

extension StringProtocol {
    /// Initialize from an `ASCIIString` instance.
    @inlinable
    public init(_ asciiString: ASCIIString) {
        self = Self(stringLiteral: asciiString.stringValue)
    }
}

// MARK: - Category Methods

extension StringProtocol {
    /// Converts a string to `ASCIIString` exactly.
    /// Returns `nil` if `self` is not encodable as ASCII.
    @inlinable @_disfavoredOverload
    public var asciiString: ASCIIString? {
        ASCIIString(exactly: self)
    }
    
    /// Converts a `String` to `ASCIIString` lossily.
    ///
    /// Performs a lossy conversion, transforming characters to printable ASCII substitutions where
    /// necessary.
    ///
    /// Note that some characters may be transformed to representations that occupy more than one
    /// ASCII character. For example: char 189 (½) will be converted to "1/2"
    ///
    /// Where a suitable character substitution can't reasonably be performed, a question-mark "?"
    /// will be substituted.
    @available(OSX 10.11, iOS 9.0, *)
    public var asciiStringLossy: ASCIIString {
#if canImport(Darwin)
        let this = self
#else
        let this = String(self) as NSString
#endif
        let transformed = this.applyingTransform(
            StringTransform("Latin-ASCII"),
            reverse: false
        )
        
        let components = (transformed ?? String(self))
            .components(separatedBy: CharacterSet.asciiPrintable.inverted)
        
        return ASCIIString(exactly: components.joined(separator: "?"))
            ?? ASCIIString("")
    }
}
