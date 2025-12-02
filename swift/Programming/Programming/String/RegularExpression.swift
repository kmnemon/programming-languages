//
//  RegularExpression.swift
//  Programming
//
//  Created by ke on 12/2/25.
//

import Foundation


//1. using swift range(utf8) warp the Foundation NSRange(utf16)
extension NSRegularExpression {
    func firstMatch(in input: String) -> Substring? {
        // NSRegularExpression expects the "substring" in which
        // to search as an NSRange.
        var inputRange = NSRange(input.startIndex..., in: input)
        let utf16Length = inputRange.length
        while true {
            let matchNSRange = self.rangeOfFirstMatch(in: input, range: inputRange)
            guard matchNSRange != NSRange(location: NSNotFound, length: 0) else {
                // Pattern not found.
                return nil
            }
            // Convert NSRange to Swift range.
            guard let matchRange = Range(matchNSRange, in: input) else {
                // Match doesn’t fall on a Character boundary → start over.
                inputRange.location =
                matchNSRange.location + matchNSRange.length
                inputRange.length = utf16Length - inputRange.location
                continue
            }
            return input[matchRange]
        }
    }
}

func exampleOfRegularExpression() {
    let input = "My favorite numbers are -9, 27, and 81."
    let regex = try! NSRegularExpression(pattern: "-?[0-9]+")
    if let match = regex.firstMatch(in: input) {
        print("Found: \(match)")
    } else {
        print("Not found")
    }
}
