//
//  MockAPIManager.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation
class MockAPIManager : NetworkManager{
    func getDataFrom(_ serverUrl: String) async throws -> [LocationData]? {
        return [LocationData(name: "NewYork", lat: 12.12, lon: 9.99, country: "USA", state: "NY"),
                LocationData(name: "California", lat: 11.11, lon: 8.88, country: "USA", state: "CA"),
                LocationData(name: "Hyderabad", lat: 10.10, lon: 7.77, country: "India", state: "TG")
        ]
    }
}
