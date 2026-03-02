//
//  MakeCodable.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//

import Foundation
import CoreLocation

struct MakeCodable {}



//1. make the type you donot own codable, CLLocationCoordinate2D do not comform Codable

//1.implement CodingKey, encode, init(decoder)
struct Placemark5: Codable {
    var name: String
    var coordinate: CLLocationCoordinate2D
}

extension Placemark5 {
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        // Encode latitude and longitude separately.
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        // Reconstruct CLLocationCoordinate2D from lat/lon.
        self.coordinate = CLLocationCoordinate2D(
            latitude: try container.decode(Double.self, forKey: .latitude),
            longitude: try container.decode(Double.self, forKey: .longitude)
        )
    }
}


//2. using nested container
struct Placemark6: Encodable {
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    private enum CodingKeys: CodingKey {
        case name
        case coordinate
    }
    // The coding keys for the nested container.
    private enum CoordinateCodingKeys: CodingKey {
        case latitude
        case longitude
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var coordinateContainer = container.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coordinate)
        try coordinateContainer.encode(coordinate.latitude, forKey: .latitude)
        try coordinateContainer.encode(coordinate.longitude, forKey: .longitude)
    }
}

//3.stick with our custom Coordinate struct for storage and Codable conformance, and to expose the CLLocationCoordinate2D type to clients as a computed property


struct Placemark7: Codable {
    struct Coordinate: Codable {
        var latitude: Double
        var longitude: Double
        // Nothing to implement here.
    }
    
    var name: String
    private var _coordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: _coordinate.latitude,
                                          longitude: _coordinate.longitude)
        }
        set {
            _coordinate = Coordinate(latitude: newValue.latitude,
                                     longitude: newValue.longitude)
        }
    }
    private enum CodingKeys: String, CodingKey {
        case name
        case _coordinate = "coordinate"
    }
}

