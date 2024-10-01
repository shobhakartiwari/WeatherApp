# WeatherApp

## Overview
WeatherApp is a SwiftUI-based iOS application that allows users to search for any location and view the current weather conditions in real-time. The app is designed using the MVVM-C (Model-View-ViewModel-Coordinator) architecture, ensuring a clean and scalable structure.

## Features
- **Search Functionality**: Users can search for cities to view current weather conditions.
- **Weather Information**: Displays details such as temperature, humidity, and weather conditions.
- **Error Handling**: Alerts the user in case of any data fetch errors.
- **Coordinator Pattern**: Manages view navigation cleanly and efficiently.
- **MVVM-C Architecture**: Separation of concerns between UI, business logic, and navigation.

## Project Structure-

### **Common**
- `Constants`: Stores API-related constants (e.g., API keys, URLs).

### **Coordinator**
- `Coordinator`: Handles app navigation logic.
- `Page`: Enum defining different pages in the app.

### **Network**
- `NetworkProtocol`: Defines the API methods.
- `APIManager`: Performs the actual network requests.
- `MockAPIManager`: Mocks the network calls for unit testing purposes.

### **Models**
- `GeocodingAPIModel`: Data model representing geocoding information.
- `WeatherDataModel`: Data model representing weather conditions like temperature and humidity.

### **Views**
- `SplashView`: Displays the splash screen.
- `CoordinatorView`: Main view handling navigation.
- `ContentView`: Displays the weather search bar and results.
- `LocationDetailView`: Shows detailed weather information for a selected location.

### **ViewModels**
- `WeatherDataViewModel`: Manages weather data fetching and processing.
- `LocationDataViewModel`: Handles location-based search.

### **Assets**
- Contains images and icons used in the app.

### **Preview Content**
- Assets for SwiftUI Previews in Xcode.

### **Tests**
- `WeatherAppTests`: Unit tests for the app's functionality.
- `WeatherAppUITests`: UI tests to ensure the app works correctly.


## ScreenShots : 
<img width="300" alt="Screenshot 2024-09-24 at 11 59 13 AM" src="https://github.com/user-attachments/assets/cadb4d67-ace8-4672-b003-941854d79e27">


## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/WeatherApp.git
