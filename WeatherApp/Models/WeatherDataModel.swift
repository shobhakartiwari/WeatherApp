//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation

struct LocationWeatherData: Codable {
    let weather: [Weather]
    let main: Temperatures
    let visibility: Double?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Double?
    let sys: Sys?
    let timezone: Int?
    let id: Int
    let name: String?
}

struct Weather: Codable {
    let id: Int
    let main: String?
    let description: String?
    let icon: String?
}

struct Temperatures: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Double?
    let sea_level: Double?
    let grnd_level: Double?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

struct Rain: Codable {
    let lh: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
