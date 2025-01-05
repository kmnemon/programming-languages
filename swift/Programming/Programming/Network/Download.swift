//
//  Download.swift
//  Programming
//
//  Created by ke on 1/5/25.
//

import Foundation

extension Download {
    struct DownloadFile: Codable, Identifiable, Equatable {
      var id: String { return name }
      let name: String
      let size: Int
      let date: Date
      static let empty = DownloadFile(name: "", size: 0, date: Date())
    }
}


struct Download {
    //1. single download
    static func download(fileName: String) async throws -> Data {
        guard let url = URL(string: "http://localhost:9091/file/download?filename=\(fileName)") else {
            throw "Could not create the URL."
        }
        
        let (data, reponse) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard (reponse as? HTTPURLResponse)?.statusCode == 200 else {
            throw "the server responded with an error"
        }
        
        return data
    }
    
    //2. download support multi-part download and progress
    static func multiPartDownloadWithProgress(file: DownloadFile) async throws -> Data {
        func partInfo(index: Int, of count: Int) -> (offset: Int, size: Int, name: String) {
            let standardPartSize = Int((Double(file.size) / Double(count)).rounded(.up))
            let partOffset = index * standardPartSize
            let partSize = min(standardPartSize, file.size - partOffset)
            let partName = "\(file.name) (part \(index + 1))"
            return (offset: partOffset, size: partSize, name: partName)
        }
        let total = 4
        let parts = (0..<total).map { partInfo(index: $0, of: total) }
        
        // Add challenge code here
        async let data0 = partialDownloadWithProgress(fileName: file.name, name: parts[0].name, size: parts[0].size, offset: parts[0].offset)
        async let data1 = partialDownloadWithProgress(fileName: file.name, name: parts[1].name, size: parts[1].size, offset: parts[1].offset)
        async let data2 = partialDownloadWithProgress(fileName: file.name, name: parts[2].name, size: parts[2].size, offset: parts[2].offset)
        async let data3 = partialDownloadWithProgress(fileName: file.name, name: parts[3].name, size: parts[3].size, offset: parts[3].offset)
        
        let datas = try await [data0, data1, data2, data3]
        
        var data: Data = Data()
        for d in datas {
            data.append(d)
        }
        
        return data
    }
    
    
    static func partialDownloadWithProgress(fileName: String, name: String, size: Int, offset: Int? = nil) async throws -> Data {
        guard let url = URL(string: "http://localhost:8080/files/download?filename=\(fileName)") else {
            throw "Could not create the URL."
        }
        
        let result: (downloadStream: URLSession.AsyncBytes, response: URLResponse)
        
        if let offset = offset {
            let urlRequest = URLRequest(url: url, offset: offset, length: size)
            result = try await URLSession.shared.bytes(for: urlRequest, delegate: nil)
            
            guard (result.response as? HTTPURLResponse)?.statusCode == 206 else {
                throw "the server responded an error"
            }
        } else {
            result = try await URLSession.shared.bytes(from: url, delegate: nil)
            
            guard (result.response as? HTTPURLResponse)?.statusCode == 200 else {
                throw "wrong"
            }
        }
        
        var asyncDownloadIterator = result.downloadStream.makeAsyncIterator()
        
        var accumulator = ByteAccumulator(name: name, size: size)
        
        //using the counter == 0 to judge if the asyncDownloadIterator has no value
        while !accumulator.checkCompleted() {
            //check if the batch is full, the batch size is the chunkSize
            while !accumulator.isBatchCompleted, let byte = try await asyncDownloadIterator.next() {
                accumulator.append(byte)
            }
            
            let progress = accumulator.progress //update the progress, if we are in swiftui we can use progress variable to update the progress
        }
        
        return accumulator.data
    }
}
