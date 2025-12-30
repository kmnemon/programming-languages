//
//  PropertyWrapperDecode.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//
import Foundation


struct PropertyWrapperDecode {}

extension PropertyWrapperDecode {
    struct Coordinate: Codable {
         var latitude: Double
         var longitude: Double
        // Nothing to implement here.
    }
    
    @propertyWrapper
    struct NilWhenKeyNotFound<Value: Decodable>: Decodable {
        var wrappedValue: Value?
        init(wrappedValue: Value?) {
            self.wrappedValue = wrappedValue
        }
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.singleValueContainer()
                self.wrappedValue = try container.decode(Value.self)
            } catch DecodingError.keyNotFound {
                self.wrappedValue = nil
            }
        }
    }
    
    
    struct Placemark5: Decodable {
        var name: String
        @NilWhenKeyNotFound var coordinate: Coordinate?
    }
    
    func example() {
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
            let decoded = try decoder.decode([Placemark5].self, from: inputData)
            print(decoded) // [Berlin (nil)]
        } catch {
            print(error.localizedDescription)
        }
    }
}
