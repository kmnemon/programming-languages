//
//  ParkModel.swift
//  Programming
//
//  Created by ke Liu on 3/2/26.
//

struct ParkModel: Comparable {
    var name: String
    var country: String
    
    static func < (lhs: ParkModel, rhs: ParkModel) -> Bool {
        return (lhs.name, lhs.country) < (rhs.name, rhs.country)
    }
}

func sortedParks() {
    var parks = [
        ParkModel(name: "a", country: "US")
    ]
    
    var ascendPark = parks.sorted()
    var descendPark = parks.sorted(by: >)
}
