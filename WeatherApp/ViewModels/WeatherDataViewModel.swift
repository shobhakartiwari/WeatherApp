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
    var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func fetchData(url: String) async throws {
        do {
            let data = try await networkManager.getWeatherData(url: url)
            self.weatherData = data
        } catch let error as Errors {
            throw error
        }
    }
}
    
