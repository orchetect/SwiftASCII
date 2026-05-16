//
//  TextTransform.swift
//  SwiftASCII • https://github.com/orchetect/swift-ascii
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreFoundation
import Foundation

/// Cross-platform text transformation.
@usableFromInline
enum TextTransform: String, Sendable {
    case latinASCII = "Latin-ASCII"
}

// MARK: - Methods

extension TextTransform {
    @inlinable
    func apply(
        to source: String,
        reverse: Bool = false
    ) -> String? {
        let mutable = source.toCFMutableString()
        let isSuccess = CFStringTransform(
            mutable,
            nil,
            rawValue.toCFString(),
            reverse
        )
        guard isSuccess else { return nil }
        return mutable.toString()
    }
}

// MARK: - String Category Method

extension String {
    @inlinable
    func apply(
        transform: TextTransform,
        reverse: Bool = false
    ) -> String? {
        transform.apply(to: self, reverse: reverse)
    }
}
