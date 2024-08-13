//
//  Properties.swift
//  Programming
//
//  Created by ke on 2024/8/13.
//

import Foundation
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}


struct Properties {
    var firstValue: Int
    let length: Int
    
    //lazy stored properties
    lazy var importer = DataImporter()
    
    var center: Int {
        return length * 2
    }
    
}
