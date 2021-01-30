//
//  String.swift
//  SwiftASCII
//
//  Created by Steffan Andrews on 2021-01-29.
//  Copyright © 2021 Steffan Andrews. All rights reserved.
//

import Foundation

extension String {
	
	/// Performs a lossy conversion, transforming characters to printable ASCII substitutions where necessary.
	///
	/// Note that some characters may be transformed to representations that occupy more than one ASCII character. For example: char 189 (½) will be converted to "1/2"
	///
	/// Where a suitable character substitution can't reasonably be performed, a question-mark "?" will be substituted.
	@available(OSX 10.11, iOS 9.0, *)
	public var asciiStringLossy: ASCIIString {
		
		let transformed =
			self
			.applyingTransform(StringTransform("Latin-ASCII"),
							   reverse: false)
		
		let components =
			(transformed ?? self)
			.components(separatedBy: CharacterSet.asciiPrintable.inverted)
		
		return ASCIIString(exactly: components.joined(separator: "?"))
			?? ASCIIString("")
		
		
		
	}
	
}
