//
//  SendingData.swift
//  Programming
//
//  Created by ke on 1/4/25.
//

import Foundation

extension SendingData {
    class Order: Codable {
        enum CodingKeys: String, CodingKey {
            case type = "type"
            case name = "name"
        }
        
        var type: String = ""
        var name: String = ""
        
        init(type: String, name: String){
            self.type = type
            self.name = name
        }
    }
}


struct SendingData {
    static var order = Order(type: "nintendo", name: "switch")

    static func sendData() async {
        guard let encode = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        //debug lldb: p String(decoding: encoded, as: UTF8.self)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            //send data
            let(data, _) = try await URLSession.shared.upload(for: request, from: encode)
            
            //receive reponse data
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            print("Your order for \(decodeOrder.name) x \(decodeOrder.type.lowercased()) games is on the way!")
        } catch {
            print("Check out failed: \(error.localizedDescription)")
        }
    }
}
