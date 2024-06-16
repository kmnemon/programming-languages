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

//2.Try
func listDownloaded() throws -> Int {
    return  1
}

func handleErrorWithTry() {
    do {
        var a = try listDownloaded()
    }
    catch {
        
    }
    
    var b = try? listDownloaded()
    
    var c = try! listDownloaded()
    
}

//3 typed throws
/*
 enum StatisticsError: Error {
     case noRatings
     case invalidRating(Int)
 }
 
 func handleThrowType() {
 let ratings = []
 do throws(StatisticsError) {
     try summarize(ratings)
 } catch {
     switch error {
     case .noRatings:
         print("No ratings available")
     case .invalidRating(let rating):
         print("Invalid rating: \(rating)")
     }
 }
 
 do {
     try summarize(ratings)
 } catch {
     switch error {
     case .noRatings:
         print("No ratings available")
     case .invalidRating(let rating):
         print("Invalid rating: \(rating)")
     }
 }
 */

//defer
func deferExample() {
    print("start...")
    defer {
        print("clean...")
    }
    
    print("ending...")
}
