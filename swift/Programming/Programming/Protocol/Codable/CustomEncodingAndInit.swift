//
//  CustomEncodingAndInit.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//
import Foundation

struct CustomEncodingAndInit {}

extension CustomEncodingAndInit {
    struct Coordinate: Codable {
         var latitude: Double
         var longitude: Double
        // Nothing to implement here.
    }
    
    //1. handle miss value in decoding, using catch and reset is a nice option if only has a small numbers of property
    struct Placemark4: Codable {
        var name: String
        var coordinate: Coordinate?
        // encode(to:) is still synthesized by compiler.
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            do {
                self.coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
            } catch DecodingError.keyNotFound {
                self.coordinate = nil //reset to nil
            }
        }
    }
    
    
    // need support coordinate is nil or empty {}
    func decodingSupportNilOrEmpty() {
        let validJSONInput = """
            [
                { "name" : "Berlin" },
                { "name" : "Cape Town" }
            ]
            """
        
        let invalidJSONInput = """
            [
                {
                    "name" : "Berlin",
                    "coordinate": {}
                }
            ]
            """
        
        
        do {
            let inputData = invalidJSONInput.data(using: .utf8)!
            let decoder = JSONDecoder()
            let decoded = try decoder.decode([Placemark4].self, from: inputData)
            print(decoded) // [Berlin (nil)]
        } catch {
            print(error.localizedDescription)
        }
    }
}
