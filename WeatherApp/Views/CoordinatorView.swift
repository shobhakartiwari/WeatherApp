//
//  CoordinatorView.swift
//  WeatherApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    @State private var isActive = false
    
    var body: some View {
           ZStack {
               if isActive {
                   NavigationStack(path: $coordinator.path) {
                       coordinator.build(page: .cityList)
                           .navigationDestination(for: Page.self) { page in
                               coordinator.build(page: page)
                           }
                   }
                   .environmentObject(coordinator)
               } else {
                   SplashView(isActive: $isActive)
               }
           }
       }
}

#Preview {
    CoordinatorView()
}
