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
    private let networkManager: APIManager<[LocationData]>
    
    init(networkManager: APIManager<[LocationData]> = .shared) {
        self.networkManager = networkManager
    }
    
    func fetchData(url: String) async throws -> Void {
        let data = try await networkManager.getDataFrom(url)
        self.locations = data
    }
    
}
