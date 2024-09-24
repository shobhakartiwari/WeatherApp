//
//  MockAPIManager.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation
class MockAPIManager : NetworkManager{
    func getData(url: String) async throws -> [LocationData]? {
        return [LocationData(name: "NewYork", lat: 12.12, lon: 9.99, country: "USA", state: "NY"),
                LocationData(name: "California", lat: 11.11, lon: 8.88, country: "USA", state: "CA"),
                LocationData(name: "Hyderabad", lat: 10.10, lon: 7.77, country: "India", state: "TG")
        ]
    }
    
    func getWeatherData(url: String) async throws -> LocationWeatherData? {
        return LocationWeatherData(weather: [Weather(id: 1, main: "N/A", description: "No desc", icon: "No Image")], main: Temperatures(temp: 11.1, feels_like: 0.00, temp_min: 0.00, temp_max: 0.00, pressure: 0.00, humidity: 0.00, sea_level: 0.00, grnd_level: 0.00), visibility: 0.00, wind: Wind(speed: 0.00, deg: 0.00, gust: 0.00), rain: Rain(lh: 0.00), clouds: Clouds(all: 0), dt: 0.00, sys: Sys(country: "N/A", sunrise: 0, sunset: 0), timezone: 0, id: 0, name: "N/A")
    }
}
