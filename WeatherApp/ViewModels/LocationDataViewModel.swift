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
    
    let key = "lastTappedLocation"
    var lastTappedLocation: String {
        get {
            UserDefaults.standard.string(forKey: key) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    init(networkManager: APIManager<[LocationData]> = .shared) {
        self.networkManager = networkManager
    }
    
    func fetchData(url: String) async throws -> Void {
        let data = try await networkManager.getDataFrom(url)
        self.locations = data
    }
    
    func getLocationAPIUrlFor(searchedString: String) -> String {
        
        let searchText = searchedString.isEmpty ? lastTappedLocation : searchedString
        
        if searchText.isEmpty {
            return APIUrls.refreshUrl.rawValue
        }
        return APIUrls.domainUrl.rawValue+"\(searchText)&limit=5"+APIUrls.API_Key.rawValue
    }
}
