//
//  WeatherViewModel.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation

class WeatherViewModel {
    var weatherDataUpdated: ((WeatherResponse) -> Void)?
    var errorOccurred: ((String) -> Void)?

    func getWeather(for city: String) {
        WeatherService.shared.fetchWeather(for: city) { [weak self] result in
            switch result {
            case .success(let response):
                UserDefaultsManager.save(city: city)
                self?.weatherDataUpdated?(response)
            case .failure:
                self?.errorOccurred?("City not found or network error.")
            }
        }
    }
}
