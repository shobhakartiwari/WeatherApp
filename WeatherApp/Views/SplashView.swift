//
//  SplashView.swift
//  WeatherApp
//
//  Created by Shobhakar Tiwari on 9/24/24.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Welcome To")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .foregroundColor(.black)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
