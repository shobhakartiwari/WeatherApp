//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shobhakar on 15/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    @StateObject var viewModel = LocationDataViewModel(networkManager: APIManager.shared)
    @State var searchText = ""
    @State var showAlert = false
    @State var defaults = UserDefaults.standard
    
    private var lastTappedLocation: String {
        defaults.string(forKey: "lastTappedLocation") ?? ""
    }
    
    private var searchedApiUrl: String {
        if !searchText.isEmpty {
            return APIUrls.domainUrl.rawValue+"\(searchText)&limit=5"+APIUrls.API_Key.rawValue
        } else if !lastTappedLocation.isEmpty {
            return APIUrls.domainUrl.rawValue+"\(lastTappedLocation)&limit=5"+APIUrls.API_Key.rawValue
        }
        else {
            return APIUrls.refreshUrl.rawValue
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                LocationListView(
                    locations: viewModel.locations,
                    showAlert: $showAlert,
                    searchText: $searchText
                )
                .searchable(text: $searchText, prompt: "Search city...")
                .task { await fetchInitialData() }
                .onChange(of: searchText, perform: debouncedSearch)
                .alert("Error", isPresented: $showAlert) {
                    Text("Something went wrong")
                }
                .padding()
            }
            .refreshable { await refreshData() }
        }
    }
    
    private func fetchInitialData() async {
        if searchText.isEmpty && lastTappedLocation.isEmpty {
            print("No search text or last tapped location, skipping API call")
        } else if searchText.isEmpty {
            searchText = lastTappedLocation
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchData(url: searchedApiUrl)
        } catch {
            showAlert = true
        }
    }
    
    private func debouncedSearch(_ newValue: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            Task { await fetchData() }
        }
    }
    
    private func refreshData() async {
        do {
            try await viewModel.fetchData(url: APIUrls.refreshUrl.rawValue)
        } catch {
            showAlert = true
        }
    }
}

struct LocationListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var locations: [LocationData]
    @Binding var showAlert: Bool
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            ForEach(locations, id: \.self) { location in
                Button(action: {
                    coordinator.push(.details(location))
                }, label: {
                    Text("\(location.name), \(location.state ?? "n/a"), \(location.country ?? "n/a")")
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                })
                .onAppear {
                    UserDefaults.standard.setValue(location.name, forKey: "lastTappedLocation")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

