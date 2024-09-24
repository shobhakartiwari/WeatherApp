//
//  Page.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import Foundation

enum Page: Hashable, Identifiable {
    case cityList, details(LocationData)
    
    var id: String {
        switch self {
        case let .details(locationData):
            return locationData.name
        case .cityList:
            return self.hashValue.description
        }
    }
}
