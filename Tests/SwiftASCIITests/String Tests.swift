//
//  String Tests.swift
//  SwiftASCII
//
//  Created by Steffan Andrews on 2021-01-29.
//  Copyright © 2021 Steffan Andrews. All rights reserved.
//

#if !os(watchOS)

import XCTest
import SwiftASCII

class StringTests: XCTestCase {
	
	override func setUp() { super.setUp() }
	override func tearDown() { super.tearDown() }
	
	func testString_asciiStringLossy() {
		
		// printable ASCII chars - ensure they are kept intact and not translated
		
		for charNum in 32...126 {

			let scalar = UnicodeScalar(charNum)!

			let string = String(scalar)

			XCTAssertEqual(string.asciiStringLossy.stringValue, string)
			
		}
		
		// extended chars
		
		XCTAssertEqual("Á".asciiStringLossy.stringValue, "A")
		XCTAssertEqual("½".asciiStringLossy.stringValue, " 1/2")
		
		XCTAssertEqual("Ãñ ÂŚÇÏÎ Strïńg.".asciiStringLossy.stringValue, "An ASCII String.")
		
		// unicode substitutions
		
		XCTAssertEqual("😃".asciiStringLossy.stringValue, "?")
		
		// test context
		
		XCTAssertEqual("The long brown dog walked lazily around the short xenophobic zebra"
						.asciiStringLossy.stringValue,
					   "The long brown dog walked lazily around the short xenophobic zebra")
		
		XCTAssertEqual("Le long 🐕 chien brun se promenait paresseusement autour du petit zèbre xénophobe"
						.asciiStringLossy.stringValue,
					   "Le long ? chien brun se promenait paresseusement autour du petit zebre xenophobe")
		
		
	}
	
}

#endif

