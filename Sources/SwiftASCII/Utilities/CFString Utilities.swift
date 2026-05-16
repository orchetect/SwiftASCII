//
//  CFString Utilities.swift
//  SwiftASCII • https://github.com/orchetect/swift-ascii
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreFoundation
import Foundation

extension String {
    @inline(__always)
    func toCFMutableString() -> CFMutableString {
        let ns = NSMutableString(string: self)
        return unsafeBitCast(ns, to: CFMutableString.self)
    }

    @inline(__always)
    func toCFString() -> CFString {
        let ns = self as NSString
        return unsafeBitCast(ns, to: CFString.self)
    }
}

extension CFMutableString {
    @inline(__always)
    func toString() -> String {
        let ns = unsafeBitCast(self, to: NSMutableString.self)
        return ns as String
    }
}
