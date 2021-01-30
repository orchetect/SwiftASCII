//
//  CharacterSet.swift
//  SwiftASCII
//
//  Created by Steffan Andrews on 2021-01-29.
//  Copyright © 2021 Steffan Andrews. All rights reserved.
//

import Foundation

extension CharacterSet {
	
	/// Includes all ASCII characters, including printable and non-printable (0...127)
	internal static let ascii = CharacterSet(charactersIn: UnicodeScalar(0)...UnicodeScalar(127))
	
	/// Includes all printable ASCII characters (32...126)
	internal static let asciiPrintable = CharacterSet(charactersIn: UnicodeScalar(32)...UnicodeScalar(126))
	
	/// Includes all ASCII characters, including printable and non-printable (0...31)
	internal static let asciiNonPrintable = CharacterSet(charactersIn: UnicodeScalar(0)...UnicodeScalar(31))
	
	/// Includes all extended ASCII characters (128...255)
	internal static let asciiExtended = CharacterSet(charactersIn: UnicodeScalar(128)...UnicodeScalar(255))
	
	/// Includes all ASCII characters and extended characters (0...255)
	internal static let asciiFull = CharacterSet(charactersIn: UnicodeScalar(0)...UnicodeScalar(255))
	
}
