//
//  PropertyWrapperEncode.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//
import Foundation

struct PropertyWrapperEncode {}
extension PropertyWrapperEncode {
    
    struct Coordinate: Codable {
        @CodedAsString var latitude: Double
        @CodedAsString var longitude: Double
        // Nothing to implement here.
    }
    
    struct Placemark: Codable {
        var name: String
        var coordinate: Coordinate
    }
    
    enum Surrounding: Codable {
        case land
        case inlandWater(name: String)
        case ocean(name: String)
    }
    struct Placemark2: Codable {
        var name: String
        var coordinate: Coordinate
        var surrounding: Surrounding
    }
    
    @propertyWrapper
    struct CodedAsString: Codable {
        var wrappedValue: Double
        init(wrappedValue: Double) {
            self.wrappedValue = wrappedValue
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let str = try container.decode(String.self)
            guard let value = Double(str) else {
                let error = EncodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Invalid string representation of double value"
                )
                throw EncodingError.invalidValue(str, error)
            }
            wrappedValue = value
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(String(wrappedValue))
        }
    }
    
    func examplePropertyWrapperEncode() {
        let places = [
            Placemark(name: "Berlin", coordinate:
                        Coordinate(latitude: 52, longitude: 13)),
            Placemark(name: "Cape Town", coordinate:
                        Coordinate(latitude: -34, longitude: 18))
        ]
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(places)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            /*
             [{"name":"Berlin","coordinate":{"longitude":"13.0",
             "latitude":"52.0"}},{"name":"Cape Town",
             "coordinate":{"longitude":"18.0","latitude":"-34.0"}}]
             */
        } catch {
            print(error.localizedDescription)
        }
    }
}
