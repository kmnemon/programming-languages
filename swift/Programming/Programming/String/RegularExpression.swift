//
//  RegularExpression.swift
//  Programming
//
//  Created by ke on 12/2/25.
//

import Foundation

// new
func firstMatchExampleRegularExpression() {
    let regex = /User ID: (\d+)/

    if let match = try? regex.firstMatch(in: "User ID: 42") {
        let id = Int(match.1)!   // automatically typed as Int
        print(id) // 42
    }
}


// Old Foundation API need wrap
//1. using swift range(utf8) wrap the Foundation NSRange(utf16)
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

func firstMatchExampleOfRegularExpressionOld() {
    let input = "My favorite numbers are -9, 27, and 81."
    let regex = try! NSRegularExpression(pattern: "-?[0-9]+")
    if let match = regex.firstMatch(in: input) {
        print("Found: \(match)")
    } else {
        print("Not found")
    }
}

//2. match
extension NSRegularExpression {
    func matches(in input: String) -> [Substring] {
        let inputRange = NSRange(input.startIndex..., in: input)
        let matches = self.matches(in: input, range: inputRange)
        return matches.compactMap { match in
            guard match.range != NSRange(location: NSNotFound, length: 0) else {
                // NSTextChecking should never have a "nil" range.
                fatalError("Should never happen")
            }
            guard let matchRange = Range(match.range, in: input) else {
                // Match doesn’t fall on a Character boundary.
                return nil
            }
            return input[matchRange]
        }
    }
}

func matchExampleRegularExpressionOld() {
    let input = "My favorite numbers are -9, 27, and 81."
    let regex = try! NSRegularExpression(pattern: "-?[0-9]+")
    
    print(regex.matches(in: input)) // ["-9", "27", "81"]”
}

