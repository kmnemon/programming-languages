//
//  maperror.swift
//  Programming
//
//  Created by ke on 2024/11/12.
//

import Foundation

// Define a custom network error
enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

// Define a more general app error
enum AppError: Error {
    case invalidURL
    case networkFailure
    case unknownError
}

func fetchData() -> Result<String, NetworkError> {
    // Simulating a network request failure
    return .failure(.requestFailed)
}

func fetchDataWithMappedError() -> Result<String, AppError> {
    // Fetching the data from the network function
    let result = fetchData()
    
    // Map the error type from `NetworkError` to `AppError`
    return result.mapError { error in
        switch error {
        case .badURL:
            return .invalidURL
        case .requestFailed:
            return .networkFailure
        case .unknown:
            return .unknownError
        }
    }
}

func macError() {
    // Example usage
    let result = fetchDataWithMappedError()
    
    switch result {
    case .success(let data):
        print("Data received: \(data)")
    case .failure(let error):
        switch error {
        case .invalidURL:
            print("Error: Invalid URL")
        case .networkFailure:
            print("Error: Network failure")
        case .unknownError:
            print("Error: Unknown error")
        }
    }
}
