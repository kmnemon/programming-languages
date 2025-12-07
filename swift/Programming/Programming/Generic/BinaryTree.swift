//
//  BinaryTree.swift
//  Programming
//
//  Created by ke Liu on 12/7/25.
//

enum BinaryTree<Element> {
    case leaf
    indirect case node(Element, l: BinaryTree<Element>, r: BinaryTree<Element>)
}
//let tree: BinaryTree<Int> = .node(5, l: .leaf, r: .leaf)

extension BinaryTree {
    init(_ value: Element) {
        self = .node(value, l: .leaf, r: .leaf)
    }
}

extension BinaryTree {
    var values: [Element] {
        switch self {
        case .leaf:
            return []
        case let .node(el, left, right):
            return left.values + [el] + right.values
        }
    }
}

extension BinaryTree {
    func map<T>(_ transform: (Element) -> T) -> BinaryTree<T> {
        switch self {
        case .leaf:
            return .leaf
        case let .node(el, left, right):
            return .node(transform(el),
                         l: left.map(transform),
                         r: right.map(transform))
        }
    }
}
//let incremented: BinaryTree<Int> = tree.map { $0 + 1 }
