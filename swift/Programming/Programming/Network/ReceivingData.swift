//
//  ReceivingData.swift
//  Programming
//
//  Created by ke on 1/4/25.
//

import Foundation

extension ReceivingData {
    struct Response: Codable{
        var results: [Result]
    }
    
    struct Result: Codable{
        var trackId: Int
        var trackName: String
        var collectionName: String
    }
    
}


struct ReceivingData {
    static func receivingData() async{
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
            print("Invalid URL")
            return
        }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data){
                print(decodeResponse.results)
            }
        } catch{
            print("Invalid data")
        }
    }
}
