//
//  String Extensions Tests.swift
//  swift-ascii • https://github.com/orchetect/swift-ascii
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftASCII
import Testing

@Suite
struct StringExtensionsTests {
    @Test("String(_: ASCIIString)")
    func string_init_asciiString() {
        #expect(
            String(ASCIIString("An ASCII String.")) ==
                "An ASCII String."
        )

        #expect(
            Substring(ASCIIString("An ASCII String.")) ==
                "An ASCII String."
        )
    }

    @Test("String.asciiString")
    func string_asciiString() {
        // String

        #expect(
            "An ASCII String.".asciiString?.stringValue ==
                "An ASCII String."
        )

        #expect("Ãñ ÂŚÇÏÎ Strïńg.".asciiString == nil)

        // Substring

        #expect(
            Substring("An ASCII String.").asciiString?.stringValue ==
                "An ASCII String."
        )

        #expect(Substring("Ãñ ÂŚÇÏÎ Strïńg.").asciiString == nil)
    }

    @Test("String.asciiStringLossy")
    func string_asciiStringLossy() throws {
        // printable ASCII chars - ensure they are kept intact and not translated

        for charNum in 32 ... 126 {
            let scalar = try #require(UnicodeScalar(charNum))

            let string = String(scalar)

            #expect(string.asciiStringLossy.stringValue == string)
        }

        // extended chars

        #expect("Á".asciiStringLossy.stringValue == "A")
        #expect("½".asciiStringLossy.stringValue == " 1/2")

        #expect("Ãñ ÂŚÇÏÎ Strïńg.".asciiStringLossy.stringValue == "An ASCII String.")

        // unicode substitutions

        #expect("😃".asciiStringLossy.stringValue == "?")

        // test context

        #expect(
            "The long brown dog walked lazily around the short xenophobic zebra"
                .asciiStringLossy.stringValue ==
                "The long brown dog walked lazily around the short xenophobic zebra"
        )

        #expect(
            "Le long 🐕 chien brun se promenait paresseusement autour du petit zèbre xénophobe"
                .asciiStringLossy.stringValue ==
                "Le long ? chien brun se promenait paresseusement autour du petit zebre xenophobe"
        )

        // StringProtocol

        func testSPL<S: StringProtocol>(_ s: S) -> ASCIIString {
            s.asciiStringLossy
        }
        #expect(testSPL("Á") == "A")

        func testSP<S: StringProtocol>(_ s: S) -> ASCIIString? {
            s.asciiString
        }
        #expect(testSP("A") == "A")
        #expect(testSP("Á") == nil)

        func testSPInit<S: StringProtocol>(_ asciiString: ASCIIString, as strType: S.Type) -> S? {
            S(asciiString)
        }

        let str1: String? = testSPInit("A", as: String.self)
        #expect(str1 == "A")
        let str2: Substring? = testSPInit("A", as: Substring.self)
        #expect(str2 == "A")
    }
}
