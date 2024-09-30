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
                .onChange(of: searchText) { _, newValue in
                    debouncedSearch(newValue)
                }
                .alert("Error", isPresented: $showAlert) {
                    Text("Something went wrong")
                }
                .padding()
            }
            .refreshable { await refreshData() }
        }
    }
    
    private func fetchInitialData() async {
        if searchText.isEmpty {
            searchText = viewModel.lastTappedLocation
            await fetchData()
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchData(url: viewModel.getLocationAPIUrlFor(searchedString: searchText))
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

