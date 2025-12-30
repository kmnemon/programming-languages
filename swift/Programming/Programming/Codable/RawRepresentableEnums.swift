//
//  RawRepresentableEnums.swift
//  Programming
//
//  Created by ke Liu on 12/30/25.
//
import Foundation

func rawRepresentableEnums() {
    struct Coordinate: Codable {
         var latitude: Double
         var longitude: Double
        // Nothing to implement here.
    }
    
    enum Surrounding2: String, Codable {
        case land
        case inlandWater
        case ocean
    }
    struct Placemark2: Codable {
        var name: String
        var coordinate: Coordinate
        var surrounding: Surrounding2
    }
    
    let berlin = Placemark2(
        name: "Berlin",
        coordinate: Coordinate(latitude: 52, longitude: 13),
        surrounding: .land
    )
    
    do {
        let data = try JSONEncoder().encode(berlin)
        String(decoding: data, as: UTF8.self)
        /*
         {"name":"Berlin","coordinate":{"longitude":13,"latitude":52},
         "surrounding":"land"}
         */
    }catch {
        print(error.localizedDescription)
    }
}

func notRawRepresentableEnums() {
    enum Surrounding3: Codable {
        case land
        case inlandWater(name: String)
        case ocean(name: String)
    }
    struct Placemark3: Codable {
        var name: String
        var coordinate: Coordinate
        var surrounding: Surrounding3
    }
    let greatBlueHole = Placemark3(
        name: "Great Blue Hole",
        coordinate: Coordinate(latitude: 17.32278, longitude: -87.534444),
        surrounding: .ocean(name: "Caribbean Sea")
    )
    
    do {
        let data2 = try JSONEncoder().encode(greatBlueHole)
        String(decoding: data2, as: UTF8.self)
        /*
         {"name":"Great Blue Hole",
         "coordinate":{"longitude":-87.534443999999993,
         "latitude":17.322780000000002},
         "surrounding":{"ocean":{"name":"Caribbean Sea"}}}
         */
    } catch {
        print(error.localizedDescription)
    }
}
