//
//  WeatherServiceTest.swift
//  WeatherAppTests
//
//  Created by anudeep thudi on 10/07/24.
//

import XCTest
@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    func testFetchWeatherSuccess() {
        let service = WeatherService()
        let expectation = self.expectation(description: "Fetching weather data")
        
        service.fetchWeather(for: "New York") { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.name, "New York")
                XCTAssertNotNil(weather.main)
                XCTAssertNotNil(weather.weather.first)
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchWeatherInvalidCity() {
        let service = WeatherService()
        let expectation = self.expectation(description: "Fetching weather data")
        
        service.fetchWeather(for: "InvalidCity1234") { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

