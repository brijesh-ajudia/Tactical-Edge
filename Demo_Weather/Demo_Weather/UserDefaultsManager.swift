//
//  UserDefaultsManager.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation

class UserDefaultsManager {
    private static let cityKey = "searchedCities"

    static func save(city: String) {
        var cities = fetchCities()
        if !cities.contains(city) {
            cities.insert(city, at: 0)
            UserDefaults.standard.set(cities, forKey: cityKey)
        }
    }

    static func fetchCities() -> [String] {
        return UserDefaults.standard.stringArray(forKey: cityKey) ?? []
    }
}
