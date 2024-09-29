//
//  APIManager.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case decodingError(description: String)
    case networkError(underlying: Error)
    case serverError(statusCode: Int)
    case unknownError(description: String)

    var localizedDescription: String {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .decodingError(let description):
            return "Decoding error: \(description)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .unknownError(let description):
            return "Unknown error occurred: \(description)"
        }
    }
}

class APIManager<T: Decodable> : NetworkManager {
    // Use a computed property instead of a static stored property
    static var shared: APIManager<T> {
        return APIManager<T>()
    }
    private init() {}
    
    func getDataFrom( _ serverUrl: String) async throws -> T {
        guard let url = URL(string: serverUrl) else {
            throw NetworkError.invalidURL(url: serverUrl)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            // Here you can handle different types of errors
            if let decodingError = error as? DecodingError {
                throw NetworkError.decodingError(description: decodingError.localizedDescription)
            } else {
                // This will catch URLSession errors
                throw NetworkError.networkError(underlying: error)
            }
        }
    }
}
