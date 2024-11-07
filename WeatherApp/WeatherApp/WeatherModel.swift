//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by anudeep thudi on 10/07/24.
//

import Foundation

struct Weather: Codable {
    let main: Main
    let weather: [WeatherDetail]
    let name: String
    
    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }
    
    struct WeatherDetail: Codable {
        let description: String
        let icon: String
    }
}
