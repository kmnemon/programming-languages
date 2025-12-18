//
//  FIFOQueue.swift
//  Programming
//
//  Created by ke on 12/18/25.
//

/*
 To add Collection conformance to your type, you must declare at least the following requirements:
 * The startIndex and endIndex properties.
 * A subscript that provides at least read-only access to your type’s elements.
 * The index(after:) method for advancing an index into your collection.
 
 protocol Collection: Sequence {
 /// A type representing the sequence's elements.
 associatedtype Element
 /// A type that represents a position in the collection.
 associatedtype Index: Comparable
 /// The position of the first element in a non-empty collection.
 var startIndex: Index { get }
 /// The collection's "past the end" position — that is, the position one
 /// greater than the last valid subscript argument.
 var endIndex: Index { get }
 /// Returns the position immediately after the given index.
 func index(after i: Index) -> Index
 /// Accesses the element at the specified position.
 subscript(position: Index) -> Element { get }
 }
 */

/// An efficient variable-size FIFO queue of elements of type `Element`.
struct FIFOQueue<Element> {
    private var left: [Element] = []
    private var right: [Element] = []
    /// Add an element to the back of the queue.
    /// - Complexity: O(1).
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    /// Removes front of the queue.
    /// Returns `nil` if the queue is empty.
    /// - Complexity: Amortized O(1).
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    
    public func index(after i: Int) -> Int {
        precondition(i >= startIndex && i < endIndex, "Index out of bounds")
        return i + 1
    }
    
    public subscript(position: Int) -> Element {
        precondition((startIndex..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.endIndex - position - 1]
        } else {
            return right[position - left.endIndex]
        }
    }
}

extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(left: elements.reversed(), right: [])
    }
}
