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

//2.Try/catch
enum StatisticsError: Error {
    case noRatings
    case invalidRating(Int)
}

func listDownloaded() throws {
    throw StatisticsError.noRatings
}

func handleErrorWithTry() {
    do {
        var a = try listDownloaded()
    } catch StatisticsError.noRatings {
        print(".noRatings")
    } catch StatisticsError.invalidRating {
        print(".invalidRating")
    } catch {
        print("unexpected error")
    }
    
    var b = try? listDownloaded()
    
    var c = try! listDownloaded()
    
}

//3 Try/catch Typed throws
func summarize() throws(StatisticsError) {
    throw StatisticsError.noRatings
}

func handleThrowType() {
    do throws(StatisticsError) {
        try summarize()
    } catch {
        switch error {
            case .noRatings:
                print("No ratings available")
            case .invalidRating(let rating):
                print("Invalid rating: \(rating)")
        }
    }
    
    //If a function or do block throws errors of only a single type, Swift infers that this code is using typed throws. Using this shorter syntax
    do {
        try summarize()
    } catch {
        switch error {
            case .noRatings:
                print("No ratings available")
            case .invalidRating(let rating):
                print("Invalid rating: \(rating)")
        }
    }
    
}
    
