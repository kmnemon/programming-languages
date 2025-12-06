//
//  StringLiteral.swift
//  Programming
//
//  Created by ke Liu on 12/6/25.
//

//1. String literal
extension String {
    var htmlEscaped: String {
        // Replace all opening and closing brackets.
        // A "real" implementation would be more sophisticated.
        return replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }
}
struct SafeHTML {
    private(set) var value: String
    init(unsafe html: String) {
        self.value = html.htmlEscaped
    }
}

extension SafeHTML: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
}

func stringLiteralExample() {
    let safe: SafeHTML = "<p>...</p>"
    print(safe.value)
    //using init(stringLiteral value: StringLiteralType) to initial SafeHTML
    //safe: <p>...</p>
}

//2. String interpolation
extension SafeHTML: ExpressibleByStringInterpolation {
    init(stringInterpolation: SafeHTML) {
        self.value = stringInterpolation.value
    }
}

extension SafeHTML: StringInterpolationProtocol {
    init(literalCapacity: Int, interpolationCount: Int) {
        self.value = ""
        value.reserveCapacity(literalCapacity)
    }
    mutating func appendLiteral(_ literal: String) {
        value += literal
    }
    mutating func appendInterpolation<T>(_ x: T) {
        self.value += String(describing: x).htmlEscaped
    }
    
    mutating func appendInterpolation<T>(raw x: T) {
        self.value += String(describing: x)
    }
}

func stringInterpolationExample() {
    let unsafeInput = "<script>alert('Oops!')</script>"
    let safe: SafeHTML = "<li>Username: \(unsafeInput)</li>"
    print(safe.value)
    /*
     SafeHTML(value: "<li>Username: &lt;script&gt;alert(\'Oops!\')&lt;/script&gt;</li>")
     */
    
    let star = "<sup>*</sup>"
    let safe2: SafeHTML = "<li>Username\(raw: star): \(unsafeInput)</li>"
    print(safe2.value)
    /*
     SafeHTML(value: "<li>Username<sup>*</sup>: &lt;script&gt;alert(\'Oops!\')&lt;/script&gt;</li>")
     */
}
