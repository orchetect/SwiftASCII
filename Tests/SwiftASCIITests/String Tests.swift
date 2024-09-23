//
//  String Tests.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import XCTest
import SwiftASCII

class StringTests: XCTestCase {
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testString_init_asciiString() {
        XCTAssertEqual(
            String(ASCIIString("An ASCII String.")),
            "An ASCII String."
        )
        
        XCTAssertEqual(
            Substring(ASCIIString("An ASCII String.")),
            "An ASCII String."
        )
    }
    
    func testString_asciiString() {
        // String
        
        XCTAssertEqual(
            "An ASCII String.".asciiString?.stringValue,
            "An ASCII String."
        )
        
        XCTAssertNil("Ãñ ÂŚÇÏÎ Strïńg.".asciiString)
        
        // Substring
        
        XCTAssertEqual(
            Substring("An ASCII String.").asciiString?.stringValue,
            "An ASCII String."
        )
        
        XCTAssertNil(Substring("Ãñ ÂŚÇÏÎ Strïńg.").asciiString)
    }
    
    func testString_asciiStringLossy() {
        // printable ASCII chars - ensure they are kept intact and not translated
        
        for charNum in 32 ... 126 {
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
        
        XCTAssertEqual(
            "The long brown dog walked lazily around the short xenophobic zebra"
                .asciiStringLossy.stringValue,
            "The long brown dog walked lazily around the short xenophobic zebra"
        )
        
        XCTAssertEqual(
            "Le long 🐕 chien brun se promenait paresseusement autour du petit zèbre xénophobe"
                .asciiStringLossy.stringValue,
            "Le long ? chien brun se promenait paresseusement autour du petit zebre xenophobe"
        )
        
        // StringProtocol
        
        func testSPL<S: StringProtocol>(_ s: S) -> ASCIIString {
            s.asciiStringLossy
        }
        XCTAssertEqual(testSPL("Á"), "A")
        
        func testSP<S: StringProtocol>(_ s: S) -> ASCIIString? {
            s.asciiString
        }
        XCTAssertEqual(testSP("A"), "A")
        XCTAssertEqual(testSP("Á"), nil)
        
        func testSPInit<S: StringProtocol>(_ asciiString: ASCIIString, as strType: S.Type) -> S? {
            S(asciiString)
        }
        
        let str1: String? = testSPInit("A", as: String.self)
        XCTAssertEqual(str1, "A")
        let str2: Substring? = testSPInit("A", as: Substring.self)
        XCTAssertEqual(str2, "A")
    }
}
