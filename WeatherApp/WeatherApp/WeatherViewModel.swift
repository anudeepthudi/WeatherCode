//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by anudeep thudi on 10/07/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = "-"
    @Published var description: String = "-"
    @Published var humidity: String = "-"
    @Published var icon: String = ""
    
    private let weatherService = WeatherService()
    
    func fetchWeather() {
        weatherService.fetchWeather(for: cityName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.temperature = "\(weather.main.temp)°C"
                    self?.description = weather.weather.first?.description.capitalized ?? "-"
                    self?.humidity = "\(weather.main.humidity)%"
                    self?.icon = weather.weather.first?.icon ?? ""
                    
                    // Cache the last searched city
                    UserDefaults.standard.set(self?.cityName, forKey: "LastCity")
                    
                case .failure(let error):
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
    
    func loadLastCity() {
        if let lastCity = UserDefaults.standard.string(forKey: "LastCity") {
            cityName = lastCity
            fetchWeather()
        }
    }
}
