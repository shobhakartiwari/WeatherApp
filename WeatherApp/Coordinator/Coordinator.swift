//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Shobhakar on 9/23/24.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .cityList:
            ContentView()
        case let .details(location):
            LocationDetailView(location: location)
        }
    }
}

