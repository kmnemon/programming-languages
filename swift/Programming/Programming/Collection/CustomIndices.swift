//
//  CustomIndice.swift
//  Programming
//
//  Created by ke Liu on 12/20/25.
//
/*
 this just example, The Swift Algorithms package provides a lazy variant of split, among many other useful collection algorithms. You should use that one instead of our version in production code.)
 */

extension Substring {
    var nextWordRange: Range<Index> {
        let start = drop(while: { $0 == " "})
        let end = start.firstIndex(where: { $0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
}

struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>
    fileprivate init(_ range: Range<Substring.Index>) {
        self.range = range
    }
    static func <(lhs: WordsIndex, rhs: WordsIndex) -> Bool {
        lhs.range.lowerBound < rhs.range.lowerBound
    }
}

struct Words {
    let string: Substring
    let startIndex: WordsIndex
    
    init(_ s: String) {
        self.init(s[...])
    }
    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    public var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}

extension Words {
    public subscript(index: WordsIndex) -> Substring {
        string[index.range]
    }
}

extension Words: Collection {
    public func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else { return endIndex }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

//Array(Words(" hello world  test  ").prefix(2)) // ["hello", "world"]


//Using the same type for a collection and its SubSequence
/*
 Slice is a perfectly good default subsequence type, but every time you write a custom collection, it’s worth investigating whether or not you can make the collection its own SubSequence. For Words, this is easy to do:
    So the subscript return Words, not Slice<Words>
 */
extension Words {
    subscript(range: Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}

func exampleWords() {
    let words: Words = Words("one two three")
    let onePastStart = words.index(after: words.startIndex)
    
    let firstDropped2 = words.suffix(from: onePastStart)
}
