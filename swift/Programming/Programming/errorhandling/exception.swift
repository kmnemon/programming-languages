//
//  exception.swift
//  Programming
//
//  Created by ke on 2024/4/22.
//

import Foundation


//1.Result
func listDownloadedPhotos(inGallery: String) throws ->[String]{
    return []
}

func availableRainyWeekendPhotos() -> Result<[String], Error> {
    return Result {
        try listDownloadedPhotos(inGallery: "A Rainy Weekend")
    }
}
