//
//  ASCIIString Tests.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2021-2024 Steffan Andrews • Licensed under MIT License
//

import SwiftASCII
import XCTest

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
    
    func testInit_StringVariable() {
        let str1 = ""
        XCTAssertEqual(ASCIIString(str1).stringValue, "" as String)
        
        let str2 = "A string"
        XCTAssertEqual(ASCIIString(str2).stringValue, "A string" as String)
        
        let str3 = "Emöji 😃"
        XCTAssertEqual(ASCIIString(str3).stringValue, "Emoji ?" as String)
    }
    
    func testInit_stringLiteral() {
        // init(stringLiteral:)
        
        XCTAssertEqual(ASCIIString("").stringValue, "" as String)
        XCTAssertEqual(ASCIIString("A string").stringValue, "A string" as String)
        XCTAssertEqual(ASCIIString("Emöji 😃").stringValue, "Emoji ?" as String)
    }
    
    func testCustomDebugStringConvertible() {
        XCTAssertEqual(
            ASCIIString("").debugDescription,
            #"ASCIIString("")"# as String
        )
        
        XCTAssertEqual(
            ASCIIString("A string").debugDescription,
            #"ASCIIString("A string")"# as String
        )
        
        XCTAssertEqual(
            ASCIIString("Emöji 😃").debugDescription,
            #"ASCIIString("Emoji ?")"# as String
        )
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
    
    func testCodable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let str = ASCIIString("A string")
        
        let encoded = try encoder.encode(str)
        let decoded = try decoder.decode(ASCIIString.self, from: encoded)
        
        XCTAssertEqual(str, decoded)
    }
    
    func testStaticInits() {
        let str: ASCIIString = .lossy("Emöji 😃")
        
        XCTAssertEqual(str.stringValue, "Emoji ?" as String)
        
        let _: [ASCIIString] = [
            .lossy("A string"),
            .exactly("")!,
            .exactly(Data([65]))!
        ]
        
        let _: [ASCIIString?] = [
            .lossy("A string"),
            .exactly(""),
            .exactly(Data([65]))
        ]
    }
    
    func testInterpolation() {
        XCTAssertEqual(
            ASCIIString("AB") + ASCIIString("CD"),
            ASCIIString("ABCD")
        )
    }
    
    func testJoined() {
        XCTAssertEqual(
            [ASCIIString("AB"), ASCIIString("CD")].joined(),
            ASCIIString("ABCD")
        )
        
        XCTAssertEqual(
            [ASCIIString("AB"), ASCIIString("CD")].joined(separator: "_"),
            ASCIIString("AB_CD")
        )
        
        XCTAssertEqual(
            [ASCIIString("AB"), ASCIIString("CD")].joined(separator: "123"),
            ASCIIString("AB123CD")
        )
    }
}
