//
//  WeatherDataViewModel.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation
@MainActor

class WeatherDataViewModel: ObservableObject {
    @Published var weatherData: LocationWeatherData?
    private let networkManager: APIManager<LocationWeatherData>
    init(network: APIManager<LocationWeatherData> = .shared) {
        self.networkManager = network
    }
    func fetchData(url: String) async throws {
        do {
            let data = try await networkManager.getDataFrom(url)
            self.weatherData = data
        } catch let error as NetworkError {
            throw error
        }
    }
}
    
