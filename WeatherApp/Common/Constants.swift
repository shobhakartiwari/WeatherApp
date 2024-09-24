//
//  Constants.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation
enum APIUrls: String {
    case refreshUrl = "https://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=fe9b915474da601ab3e484de18ced03c"
    case domainUrl = "https://api.openweathermap.org/geo/1.0/direct?q="
    case API_Key = "&appid=fe9b915474da601ab3e484de18ced03c"
    case locationBaseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    case imageUrl = "https://openweathermap.org/img/wn/"
}
