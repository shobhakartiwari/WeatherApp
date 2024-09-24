//
//  LocationDataViewModel.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import Foundation
@MainActor

class LocationDataViewModel: ObservableObject {
    @Published var locations: [LocationData] = []
    var networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func fetchData(url: String) async throws -> Void {
        let data = try await networkManager.getData(url: url)
        self.locations = data ?? []
    }
}
