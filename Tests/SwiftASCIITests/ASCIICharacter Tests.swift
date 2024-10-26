//
//  ASCIICharacter Tests.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2021-2024 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftASCII
import Testing

@Suite struct ASCIICharacterTests {
    @Test("init(exactly: Character)") func init_exactly_Character() {
        #expect(ASCIICharacter(exactly: Character("A"))?.characterValue == "A")
        #expect(ASCIICharacter(exactly: "A")?.characterValue == "A")
        
        #expect(ASCIICharacter(exactly: "😃") == nil)
        #expect(ASCIICharacter(exactly: "Ä") == nil)
    }
    
    @Test("init(exactly: StringProtocol)") func init_exactly_StringProtocol() {
        #expect(ASCIICharacter(exactly: "A string") == nil)
    }
    
    @Test("init(BinaryInteger)") func init_exactly_Data() {
        #expect(ASCIICharacter(exactly: Data([65])) == "A")
        
        // non-printable ASCII chars
        #expect(ASCIICharacter(exactly: Data([0]))?.asciiValue == 0)
        
        // non-ASCII char numbers
        #expect(ASCIICharacter(exactly: Data([128])) == nil) // extended ASCII
    }
    
    @Test("init(BinaryInteger)") func init_BinaryInteger() {
        #expect(ASCIICharacter(65) == "A")
        
        // non-printable ASCII chars
        #expect(ASCIICharacter(0)?.asciiValue == 0)
        
        // non-ASCII char numbers
        #expect(ASCIICharacter(128) == nil) // extended ASCII
        #expect(ASCIICharacter(300) == nil) // out of bounds
    }
    
    @Test("asciiValue") func asciiValue() {
        #expect(ASCIICharacter(65)?.asciiValue == 65)
        
        // non-printable ASCII chars
        #expect(ASCIICharacter(0)?.asciiValue == 0)
        
        // non-ASCII char numbers
        #expect(ASCIICharacter(128)?.asciiValue == nil) // extended ASCII
        #expect(ASCIICharacter(300)?.asciiValue == nil) // out of bounds
    }
    
    @Test("rawData") func rawData() {
        #expect(ASCIICharacter(65)?.rawData == Data([65]))
        
        // non-printable ASCII chars
        #expect(ASCIICharacter(0)?.rawData == Data([0]))
        
        // non-ASCII char numbers
        #expect(ASCIICharacter(128)?.rawData == nil) // extended ASCII
        #expect(ASCIICharacter(300)?.rawData == nil) // out of bounds
    }
    
    @Test("CustomStringConvertible") func customStringConvertible() {
        #expect(String(describing: ASCIICharacter(65)!) == "A")
        
        // non-printable ASCII chars
        #expect(String(describing: ASCIICharacter(0)!) == "?")
    }
    
    @Test("CustomDebugStringConvertible") func customDebugStringConvertible() {
        #expect(
            ASCIICharacter(65)!.debugDescription ==
            #"ASCIICharacter(#65: "A")"#
        )
        
        // non-printable ASCII chars
        #expect(
            ASCIICharacter(0)!.debugDescription ==
            #"ASCIICharacter(#0: "?")"#
        )
    }
    
    @Test("Equatable") func equatable() {
        // Self & Self
        
        #expect(ASCIICharacter("A") == ASCIICharacter("A"))
        #expect((ASCIICharacter("A") != ASCIICharacter("A")) == false)
        
        #expect(ASCIICharacter("A") == ASCIICharacter("A"))
        #expect((ASCIICharacter("A") != ASCIICharacter("A")) == false)
        
        // Self & Character
        
        #expect(ASCIICharacter("A") == Character("A"))
        #expect((ASCIICharacter("A") != Character("A")) == false)
        
        #expect(Character("A") == ASCIICharacter("A"))
        #expect((Character("A") != ASCIICharacter("A")) == false)
    }
    
    @Test("Codable") func codable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let str = ASCIICharacter("A")
        
        let encoded = try encoder.encode(str)
        let decoded = try decoder.decode(ASCIICharacter.self, from: encoded)
        
        #expect(str == decoded)
    }
    
    @Test("Static Constructors") func staticConstructors() {
        let str: ASCIICharacter = .lossy("😃")
        
        #expect(str.characterValue == Character("?"))
        
        let _: [ASCIICharacter] = [
            .lossy("A"),
            .lossy("A string"),
            .lossy(Character("A")),
            .exactly(Character("A"))!,
            .exactly("A")!,
            .exactly(Data([65]))!,
            .exactly(65)!
        ]
        
        let _: [ASCIICharacter?] = [
            .lossy("A"),
            .lossy("A string"),
            .lossy(Character("A")),
            .exactly(Character("A")),
            .exactly("A"),
            .exactly(Data([65])),
            .exactly(65)
        ]
    }
    
    @Test("String Interpolation") func interpolation() {
        #expect(
            ASCIICharacter("A") + ASCIICharacter("B") ==
            ASCIIString("AB")
        )
        
        #expect(
            ASCIICharacter("A") + ASCIIString("BC") ==
            ASCIIString("ABC")
        )
        
        #expect(
            ASCIIString("AB") + ASCIICharacter("C") ==
            ASCIIString("ABC")
        )
    }
    
    @Test("joined()") func joined() {
        #expect(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined() ==
            ASCIIString("AB")
        )
        
        #expect(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined(separator: "_") ==
            ASCIIString("A_B")
        )
        
        #expect(
            [ASCIICharacter("A"), ASCIICharacter("B")].joined(separator: "123") ==
            ASCIIString("A123B")
        )
    }
}
