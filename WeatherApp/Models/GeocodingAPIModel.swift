//
//  GeocodingAPIModel.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation
//We've array of GeoCodings

struct LocationData: Codable, Hashable {
    let name: String
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
}
