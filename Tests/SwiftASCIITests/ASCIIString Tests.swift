//
//  ASCIIString Tests.swift
//  SwiftASCII • https://github.com/orchetect/SwiftASCII
//  © 2021-2024 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftASCII
import Testing

@Suite struct ASCIIStringTests {
    @Test("init(exactly:)") func init_exactly() {
        #expect(ASCIIString(exactly: "A string")!.stringValue == "A string" as String)
        #expect(ASCIIString(exactly: "Emöji 😃") == nil)
        #expect(ASCIIString(exactly: "😃") == nil)
    }
    
    @Test("init(data:)") func init_data() {
        
        #expect(ASCIIString(exactly: Data())!.stringValue == "" as String)
        #expect(ASCIIString(exactly: Data([0x41, 0x30]))!.stringValue == "A0" as String)
        
        // ASCII only, reject extended ASCII (128...255)
        #expect(ASCIIString(exactly: Data([132]))?.stringValue != "ä" as String)
    }
    
    @Test("CustomStringConvertible") func customStringConvertible() {
        #expect("\(ASCIIString(""))" == "" as String)
        #expect("\(ASCIIString("A string"))" == "A string" as String)
        #expect("\(ASCIIString("Emöji 😃"))" == "Emoji ?" as String)
    }
    
    @Test("init(_: String)") func init_StringValue() {
        let str1 = ""
        #expect(ASCIIString(str1).stringValue == "" as String)
        
        let str2 = "A string"
        #expect(ASCIIString(str2).stringValue == "A string" as String)
        
        let str3 = "Emöji 😃"
        #expect(ASCIIString(str3).stringValue == "Emoji ?" as String)
    }
    
    @Test("init(stringLiteral:)") func init_stringLiteral() {
        #expect(ASCIIString("").stringValue == "" as String)
        #expect(ASCIIString("A string").stringValue == "A string" as String)
        #expect(ASCIIString("Emöji 😃").stringValue == "Emoji ?" as String)
    }
    
    @Test("CustomDebugStringConvertible") func customDebugStringConvertible() {
        #expect(
            ASCIIString("").debugDescription ==
            #"ASCIIString("")"# as String
        )
        
        #expect(
            ASCIIString("A string").debugDescription ==
            #"ASCIIString("A string")"# as String
        )
        
        #expect(
            ASCIIString("Emöji 😃").debugDescription ==
            #"ASCIIString("Emoji ?")"# as String
        )
    }
    
    @Test("Equatable") func equatable() {
        // Self & Self
        
        #expect(ASCIIString("A string") == ASCIIString("A string"))
        #expect((ASCIIString("A string") != ASCIIString("A string")) == false)
        
        // Self & String
        
        #expect(ASCIIString("A string") == "A string" as String)
        #expect((ASCIIString("A string") != "A string" as String) == false)
        
        #expect("A string" as String == ASCIIString("A string"))
        #expect(("A string" as String != ASCIIString("A string")) == false)
    }
    
    @Test("Codable") func codable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let str = ASCIIString("A string")
        
        let encoded = try encoder.encode(str)
        let decoded = try decoder.decode(ASCIIString.self, from: encoded)
        
        #expect(str == decoded)
    }
    
    @Test("Static Constructors") func staticConstructors() {
        let str: ASCIIString = .lossy("Emöji 😃")
        
        #expect(str.stringValue == "Emoji ?" as String)
        
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
    
    @Test("String Interpolation") func interpolation() {
        #expect(
            ASCIIString("AB") + ASCIIString("CD") ==
            ASCIIString("ABCD")
        )
    }
    
    @Test("joined()") func joined() {
        #expect(
            [ASCIIString("AB"), ASCIIString("CD")].joined() ==
            ASCIIString("ABCD")
        )
        
        #expect(
            [ASCIIString("AB"), ASCIIString("CD")].joined(separator: "_") ==
            ASCIIString("AB_CD")
        )
        
        #expect(
            [ASCIIString("AB"), ASCIIString("CD")].joined(separator: "123") ==
            ASCIIString("AB123CD")
        )
    }
}
