//
//  ASCIIString.swift
//  SwiftASCII
//
//  Created by Steffan Andrews on 2021-01-29.
//  Copyright © 2021 Steffan Andrews. All rights reserved.
//

import Foundation

/// A type containing a String instance that is guaranteed to conform to ASCII encoding.
public struct ASCIIString: Equatable, Hashable {
	
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
	
}

extension ASCIIString: ExpressibleByStringLiteral {
	
	public typealias StringLiteralType = String
	
	@inlinable public init(stringLiteral: String) {
		
		guard stringLiteral.allSatisfy({ $0.isASCII }),
			  let asciiData = stringLiteral.data(using: .ascii) else {
			
			// if ASCII encoding fails, fall back to a default string instead of throwing an exception
			
			stringValue = stringLiteral.asciiStringLossy.stringValue
			rawData = stringValue.data(using: .ascii) ?? Data([])
			return
		}
		
		stringValue = stringLiteral
		rawData = asciiData
		
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
	
	public init?(_ description: String) {
		self.init(exactly: description)
	}
	
}

extension ASCIIString {
	
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
