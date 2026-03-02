//
//  CustomCodingKeys.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//

extension customCodingKeys {
    struct Coordinate: Codable {
         var latitude: Double
         var longitude: Double
        // Nothing to implement here.
    }
    
    //1. rename the "name" to "label"
    struct Placemark2: Codable {
        var name: String
        var coordinate: Coordinate
        
        private enum CodingKeys: String, CodingKey {
            case name = "label"
            case coordinate
        }
        // Compiler-synthesized encode and decode methods
        // will use overridden CodingKeys.
    }
    
    
    //2. ignore name key
    struct Placemark3: Codable {
        var name: String = "(Unknown)"
        var coordinate: Coordinate
        
        private enum CodingKeys: CodingKey {
            case coordinate
        }
    }
    
    
}

struct customCodingKeys {}
