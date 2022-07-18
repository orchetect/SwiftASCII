//
//  ASCIICharacter Tests.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//

#if shouldTestCurrentPlatform

import XCTest
import SwiftASCII

class ASCIICharacterTests: XCTestCase {
    
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testInit_exactly_Character() {
        
        // init(exactly: Character)
        
        XCTAssertEqual(ASCIICharacter(exactly: Character("A"))?.characterValue, "A")
        XCTAssertEqual(ASCIICharacter(exactly: "A")?.characterValue, "A")
        
        XCTAssertNil(ASCIICharacter(exactly: "😃"))
        XCTAssertNil(ASCIICharacter(exactly: "Ä"))
        
    }
    
    func testInit_exactly_String() {
        
        // init(exactly: String)
        
        XCTAssertNil(ASCIICharacter(exactly: "A string"))
        
        
    }
    
    func testInit_exactly_Data() {
        
        // init(BinaryInteger)
        
        XCTAssertEqual(ASCIICharacter(exactly: Data([65])), "A")
        
        // non-printable ASCII chars
        XCTAssertEqual(ASCIICharacter(exactly: Data([0]))?.asciiValue, 0)
        
        // non-ASCII char numbers
        XCTAssertNil(ASCIICharacter(exactly: Data([128]))) // extended ASCII
        
    }
    
    func testInit_BinaryInteger() {
        
        // init(BinaryInteger)
        
        XCTAssertEqual(ASCIICharacter(65), "A")
        
        // non-printable ASCII chars
        XCTAssertEqual(ASCIICharacter(0)?.asciiValue, 0)
        
        // non-ASCII char numbers
        XCTAssertNil(ASCIICharacter(128)) // extended ASCII
        XCTAssertNil(ASCIICharacter(300)) // out of bounds
        
    }
    
    func testasciiValue() {
        
        XCTAssertEqual(ASCIICharacter(65)?.asciiValue, 65)
        
        // non-printable ASCII chars
        XCTAssertEqual(ASCIICharacter(0)?.asciiValue, 0)
        
        // non-ASCII char numbers
        XCTAssertNil(ASCIICharacter(128)?.asciiValue) // extended ASCII
        XCTAssertNil(ASCIICharacter(300)?.asciiValue) // out of bounds
        
    }
    
    func testRawData() {
        
        XCTAssertEqual(ASCIICharacter(65)?.rawData, Data([65]))
        
        // non-printable ASCII chars
        XCTAssertEqual(ASCIICharacter(0)?.rawData, Data([0]))
        
        // non-ASCII char numbers
        XCTAssertNil(ASCIICharacter(128)?.rawData) // extended ASCII
        XCTAssertNil(ASCIICharacter(300)?.rawData) // out of bounds
        
    }
    
    func testCustomStringConvertible() {
        
        XCTAssertEqual(String(describing: ASCIICharacter(65)!), "A")
        
        // non-printable ASCII chars
        XCTAssertEqual(String(describing: ASCIICharacter(0)!), "")
        
    }
    
    func testCustomDebugStringConvertible() {
        
        XCTAssertEqual(ASCIICharacter(65)!.debugDescription,
                       #"ASCIICharacter(#65: "A")"#)
        
        // non-printable ASCII chars
        XCTAssertEqual(ASCIICharacter(0)!.debugDescription,
                       #"ASCIICharacter(#0: "")"#)
        
    }
    
    func testEquatable() {
        
        // Self & Self
        
        XCTAssertTrue(ASCIICharacter("A") == ASCIICharacter("A"))
        XCTAssertFalse(ASCIICharacter("A") != ASCIICharacter("A"))
        
        XCTAssertTrue(ASCIICharacter("A") == ASCIICharacter("A"))
        XCTAssertFalse(ASCIICharacter("A") != ASCIICharacter("A"))
        
        // Self & Character
        
        XCTAssertTrue(ASCIICharacter("A") == Character("A"))
        XCTAssertFalse(ASCIICharacter("A") != Character("A"))
        
        XCTAssertTrue(Character("A") == ASCIICharacter("A"))
        XCTAssertFalse(Character("A") != ASCIICharacter("A"))
        
    }
    
    func testStaticInits() {
        
        let str: ASCIICharacter = .lossy("😃")
        
        XCTAssertEqual(str.characterValue, Character("?"))
        
        let _: [ASCIICharacter] = [.lossy("A"),
                                   .lossy("A string"),
                                   .lossy(Character("A")),
                                   .exactly(Character("A"))!,
                                   .exactly("A")!,
                                   .exactly(Data([65]))!,
                                   .exactly(65)!]
        
        let _: [ASCIICharacter?] = [.lossy("A"),
                                    .lossy("A string"),
                                    .lossy(Character("A")),
                                    .exactly(Character("A"))!,
                                    .exactly("A")!,
                                    .exactly(Data([65]))!,
                                    .exactly(65)!]
        
    }
    
    func testInterpolation() {
        
        XCTAssertEqual(ASCIICharacter("A") + ASCIICharacter("B"),
                       ASCIIString("AB"))
        
        XCTAssertEqual(ASCIICharacter("A") + ASCIIString("BC"),
                       ASCIIString("ABC"))
        
        XCTAssertEqual(ASCIIString("AB") + ASCIICharacter("C"),
                       ASCIIString("ABC"))
        
    }
    
    func testJoined() {
        
        XCTAssertEqual(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined(),
            ASCIIString("AB")
        )
        
        XCTAssertEqual(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined(separator: "_"),
            ASCIIString("A_B")
        )
        
        XCTAssertEqual(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined(separator: "123"),
            ASCIIString("A123B")
        )
        
    }
    
}

#endif
