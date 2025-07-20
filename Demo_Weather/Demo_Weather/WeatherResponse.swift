//
//  WeatherResponse.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String               // City name
    let main: Main                 // Temperature info
    let weather: [Weather]         // Array, we’ll take first element
}

struct Main: Codable {
    let temp: Double               // Temp in Kelvin → convert to Celsius in ViewModel
}

struct Weather: Codable {
    let main: String               // Condition e.g. "Rain"
    let icon: String               // Icon code e.g. "10d"
}
