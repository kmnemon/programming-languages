//
//  ByteAccumulator..swift
//  Programming
//
//  Created by ke on 1/5/25.
//

import Foundation

/// Type that accumulates incoming data into an array of bytes.
struct ByteAccumulator: CustomStringConvertible {
    private var offset = 0
    private var counter = -1
    private let name: String
    private let size: Int
    private let chunkSize: Int //split the file in chunkCount
    private let chunkCount: Int = 20
    private var bytes: [UInt8]
    var data: Data { return Data(bytes[0..<offset]) }
    
    /// Creates a named byte accumulator.
    init(name: String, size: Int) {
        self.name = name
        self.size = size
        chunkSize = max(Int(Double(size) / Double(chunkCount)), 1)
        bytes = [UInt8](repeating: 0, count: size)
    }
    
    /// Appends a byte to the accumulator.
    mutating func append(_ byte: UInt8) {
        bytes[offset] = byte
        counter += 1
        offset += 1
    }
    
    /// `true` if the current batch is filled with bytes.
    var isBatchCompleted: Bool {
        return counter >= chunkSize
    }
    
    mutating func checkCompleted() -> Bool {
        defer { counter = 0 }
        return counter == 0
    }
    
    /// The overall progress.
    var progress: Double {
        Double(offset) / Double(size)
    }
    
    var description: String {
        "[\(name)] \(sizeFormatter.string(fromByteCount: Int64(offset)))"
    }
}
