//
//  OutputStream.swift
//  Programming
//
//  Created by ke Liu on 12/7/25.
//
import Foundation

//1. output to string
func outputToStringExample() {
    var s = ""
    let numbers = [1,2,3,4]
    print(numbers, to: &s)
    //s: [1, 2, 3, 4]
}

//2. output stream
struct ArrayStream: TextOutputStream {
    var buffer: [String] = []
    
    mutating func write(_ string: String) {
        buffer.append(string)
    }
}

func outputStreamExample() {
    var stream = ArrayStream()
    print("Hello", to: &stream)
    print("World", to: &stream)
    print(stream.buffer) // ["", "Hello", "\n", "", "World", "\n"]
}

//3.outputStream write
//but extension a type you don't own to a protocol you don't own is bad practise, so using @retroactive suppress warning
extension Data: @retroactive TextOutputStream {
    mutating public func write(_ string: String) {
        self.append(contentsOf: string.utf8)
    }
}

func outputUTF8Example() {
    var utf8Data = Data()
    let string = "café"
    utf8Data.write(string)
    print(Array(utf8Data)) // [99, 97, 102, 195, 169]
}

//4. print to stderr
struct StdErr: TextOutputStream {
    mutating func write(_ string: String) {
        guard !string.isEmpty else { return }
        // Strings can be passed directly into C functions that take a
        // const char* — see the Interoperability chapter for more.
        fputs(string, stderr)
    }
}

func printToStdErrExample() {
    var standarderror = StdErr()
    print("oops!", to: &standarderror)
}
