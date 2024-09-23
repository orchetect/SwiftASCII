//
//  CharacterSet.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2021-2024 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension CharacterSet {
    /// Includes all ASCII characters, including printable and non-printable (0...127)
    static let ascii = CharacterSet(
        charactersIn: UnicodeScalar(0) ... UnicodeScalar(127)
    )
    
    /// Includes all printable ASCII characters (32...126)
    static let asciiPrintable = CharacterSet(
        charactersIn: UnicodeScalar(32) ... UnicodeScalar(126)
    )
    
    /// Includes all ASCII characters, including printable and non-printable (0...31)
    static let asciiNonPrintable = CharacterSet(
        charactersIn: UnicodeScalar(0) ... UnicodeScalar(31)
    )
    
    /// Includes all extended ASCII characters (128...255)
    static let asciiExtended = CharacterSet(
        charactersIn: UnicodeScalar(128) ... UnicodeScalar(255)
    )
    
    /// Includes all ASCII characters and extended characters (0...255)
    static let asciiFull = CharacterSet(
        charactersIn: UnicodeScalar(0) ... UnicodeScalar(255)
    )
}
