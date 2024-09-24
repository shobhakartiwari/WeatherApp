//
//  APIManager.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation

class APIManager : NetworkManager{
    static let shared = APIManager()
    private init() {}
    
    func getData(url: String) async throws -> [LocationData]? {
        guard let url = URL(string: url) else { throw Errors.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decodedData = try JSONDecoder().decode([LocationData].self, from: data)
            return decodedData
        } catch {
            throw Errors.decodeError
        }
    }
    
    func getWeatherData(url: String) async throws -> LocationWeatherData? {
        guard let url = URL(string: url) else { throw Errors.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decodedData = try JSONDecoder().decode(LocationWeatherData.self, from: data)
            return decodedData
        } catch {
            throw Errors.decodeError
        }
    }
}

enum Errors: String, Error {
    case invalidURL = "Invalid Url"
    case decodeError = "Error while decoding"
    case otherError = "Error while fetching data"
}
