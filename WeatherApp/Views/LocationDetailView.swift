//
//  LocationDetailView.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import SwiftUI

struct LocationDetailView: View {
    @StateObject var viewModel = WeatherDataViewModel(network: APIManager.shared)
    var location: LocationData?
    
    var body: some View {
        let weatherData = viewModel.weatherData
        
        ZStack {
            BackgroundView()
            ScrollView {
                VStack {
                    LocationHeader(location: location, weatherIcon: weatherData?.weather[0].icon)
                    LocationInfo(location: location, weatherData: weatherData)
                    Spacer()
                }
                .task {
                    do {
                        try await viewModel.fetchData(url: APIUrls.locationBaseUrl.rawValue+"lat=\(location?.lat ?? 0.0)&lon=\(location?.lon ?? 0.0)"+APIUrls.API_Key.rawValue) 
                    } catch {
                        print("Error in task")
                    }
                }
            }
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct LocationHeader: View {
    var location: LocationData?
    var weatherIcon: String?
    
    var body: some View {
        VStack {
            Text(location?.name ?? "N/A")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.vertical, 100)
                .foregroundColor(.black)
            
            AsyncImage(url: URL(string: APIUrls.imageUrl.rawValue+"\(weatherIcon ?? "01d")@2x.png")) { image in
                image.resizable()
                    .frame(width: 145, height: 130)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 145, height: 130)
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}


struct LocationInfo: View {
    var location: LocationData?
    var weatherData: LocationWeatherData?
    
    var body: some View {
        VStack {
            Text("Temperature : \(Int(weatherData?.main.temp ?? 0.0)-273)°C")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(5)
            
            Text("Lowest : \(Int(weatherData?.main.temp_min ?? 0.0)-273)°C")
                .font(.system(size: 18))
                .fontWeight(.medium)
            
            Text("Highest : \(Int(weatherData?.main.temp_max ?? 0.0)-273)°C")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(5)
            
            Text("Rainfall : \(Int(weatherData?.rain?.lh ?? 0))")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(.bottom,5)
            
            Text("Weather Description: \(weatherData?.weather[0].description ?? "no description")")
                .font(.system(size: 18))
                .fontWeight(.medium)
        }
    }
}


#Preview {
    LocationDetailView(location: LocationData(name: "Sample Location", lat: 10.0, lon: 20.0, country: "Sample Country", state: "Sample State"))
}

