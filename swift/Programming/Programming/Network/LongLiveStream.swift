//
//  LongLiveStream.swift
//  Programming
//
//  Created by ke on 1/4/25.
//

import Foundation

extension LongLiveStream {
    struct Stock: Hashable, Codable {
        let name: String
        let value: Double
    }
}


struct LongLiveStream {
    static private var liveURLSession: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = .infinity
        return URLSession(configuration: configuration)
    }()
    
    static func longLiveStream() async throws {
        guard let url = URL(string: "http://localhost:9091/longlivestream") else {
            throw "The URL could not be created."
        }
        
        let (stream, response) = try await liveURLSession.bytes(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        
        for try await line in stream.lines {
            let stock = try JSONDecoder()
                .decode(Stock.self, from: Data(line.utf8))
            
            print("\(stock.name) : \(stock.value)")
        }
        
    }
}
