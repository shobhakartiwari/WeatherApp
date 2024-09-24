//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Shobhakar on 15/09/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    var mockAPIManagerObj:MockAPIManager?
    var mockWeatherDataObj: WeatherDataViewModel?
    var locDetailObj: LocationDetailView?
    var viewModel: WeatherDataViewModel!
    
    @MainActor override func setUpWithError() throws {
        mockAPIManagerObj = MockAPIManager()
        mockWeatherDataObj = WeatherDataViewModel(networkManager: mockAPIManagerObj ?? MockAPIManager())
        viewModel = WeatherDataViewModel(networkManager: mockAPIManagerObj ?? MockAPIManager())
    }
    
    override func tearDownWithError() throws {
        mockAPIManagerObj = nil
        mockWeatherDataObj = nil
        locDetailObj = nil
    }
    
    func testGetData() async throws {
        Task {
            let locationData = try await mockAPIManagerObj?.getData(url: "")
            XCTAssertEqual(locationData?.count, 3)
        }
    }
    
    func testWeatherData() async throws {
        Task {
            let weatherData = try await mockAPIManagerObj?.getWeatherData(url: "")
            XCTAssertNotNil(weatherData)
        }
    }
    
    @MainActor
    func testMockWeather() async throws {
        Task {
            try await mockWeatherDataObj?.fetchData(url: "not nil")
            XCTAssertNotNil(mockWeatherDataObj?.weatherData)
        }
    }
    
    @MainActor
    func testFetchWeatherData() async {
            let url = "http://mockurl.com/weather"

            do {
                try await viewModel.fetchData(url: url)

                XCTAssertNotNil(viewModel.weatherData)
                XCTAssertEqual(viewModel.weatherData?.name, "N/A")
                XCTAssertEqual(viewModel.weatherData?.weather.first?.main, "N/A")
            } catch {
                XCTFail("Expected successful fetch but got error: \(error)")
            }
        }
    
}
