//
//  ASCIIString Tests.swift
//  SwiftASCII
//
//  Created by Steffan Andrews on 2021-01-29.
//  Copyright © 2021 Steffan Andrews. All rights reserved.
//

#if !os(watchOS)

import XCTest
@testable import SwiftASCII

class ASCIIStringTests: XCTestCase {
	
	override func setUp() { super.setUp() }
	override func tearDown() { super.tearDown() }
	
	func testInit_exactly() {
		
		// init(exactly:)
		
		XCTAssertEqual(ASCIIString(exactly: "A string")!.stringValue, "A string" as String)
		XCTAssertNil(ASCIIString(exactly: "Emöji 😃"))
		XCTAssertNil(ASCIIString(exactly: "😃"))
		
	}
	
	func testInit_data() {
		
		// init(data:)
		
		XCTAssertEqual(ASCIIString(exactly: Data())!.stringValue, "" as String)
		XCTAssertEqual(ASCIIString(exactly: Data([0x41, 0x30]))!.stringValue, "A0" as String)
		
		// ASCII only, reject extended ASCII (128...255)
		XCTAssertNotEqual(ASCIIString(exactly: Data([132]))?.stringValue, "ä" as String)
		
	}
	
	func testCustomStringConvertible() {
		
		XCTAssertEqual("\(ASCIIString(""))", "" as String)
		XCTAssertEqual("\(ASCIIString("A string"))", "A string" as String)
		XCTAssertEqual("\(ASCIIString("Emöji 😃"))", "Emoji ?" as String)
		
	}
	
	func testInit_stringLiteral() {
		
		// init(stringLiteral:)
		
		XCTAssertEqual(ASCIIString("").stringValue, "" as String)
		XCTAssertEqual(ASCIIString("A string").stringValue, "A string" as String)
		XCTAssertEqual(ASCIIString("Emöji 😃").stringValue, "Emoji ?" as String)
		
	}
	
	func testCustomDebugStringConvertible() {
		
		XCTAssertEqual(ASCIIString("").debugDescription,
						#"ASCIIString("")"# as String)
		
		XCTAssertEqual(ASCIIString("A string").debugDescription,
						#"ASCIIString("A string")"# as String)
		
		XCTAssertEqual(ASCIIString("Emöji 😃").debugDescription,
						#"ASCIIString("Emoji ?")"# as String)
		
	}
	
	func testEquatable() {
		
		// Self & Self
		
		XCTAssertTrue(ASCIIString("A string") == ASCIIString("A string"))
		XCTAssertFalse(ASCIIString("A string") != ASCIIString("A string"))
		
		// Self & String
		
		XCTAssertTrue(ASCIIString("A string") == "A string" as String)
		XCTAssertFalse(ASCIIString("A string") != "A string" as String)
		
		XCTAssertTrue("A string" as String == ASCIIString("A string"))
		XCTAssertFalse("A string" as String != ASCIIString("A string"))
		
	}
	
}

#endif
