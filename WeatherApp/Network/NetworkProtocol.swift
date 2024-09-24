//
//  NetworkProtocol.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation
protocol NetworkManager : AnyObject {
    func getData(url: String) async throws -> [LocationData]?
    func getWeatherData(url: String) async throws -> LocationWeatherData?
}
