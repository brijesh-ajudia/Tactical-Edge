//
//  ViewController.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dropdownTableView: UITableView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    private let viewModel = WeatherViewModel()
    private var searchedCities = [String]()
    private var autoRefreshTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        searchedCities = UserDefaultsManager.fetchCities()
    }
    
    private func setupTableView() {
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupBindings() {
        viewModel.weatherDataUpdated = { [weak self] weather in
            DispatchQueue.main.async {
                let celsius = weather.main.temp - 273.15
                self?.weatherLabel.text = """
                    City: \(weather.name)
                    Temp: \(String(format: "%.1f", celsius)) °C
                    Condition: \(weather.weather.first?.main ?? "-")
                    """
                
                let iconCode = weather.weather.first?.icon ?? "10d"
                let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                ImageLoader.loadImage(from: iconURL, into: self?.weatherIconImageView ?? UIImageView())
                
                self?.searchedCities = UserDefaultsManager.fetchCities()
                self?.dropdownTableView.reloadData()
            }
        }
        
        viewModel.errorOccurred = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.weatherLabel.text = "❌ \(errorMessage)"
            }
        }
    }
    
    @IBAction func getWeatherTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else {
            weatherLabel.text = "⚠️ Enter a city name!"
            return
        }
        fetchWeather(for: city)
        cityTextField.resignFirstResponder()
    }
    
    private func fetchWeather(for city: String) {
        viewModel.getWeather(for: city)
        startAutoRefresh(for: city)
    }
    
    private func startAutoRefresh(for city: String) {
        autoRefreshTimer?.invalidate() // Stop previous timer if running
        
        autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            print("⏰ Auto-refreshing weather for: \(city)")
            self?.viewModel.getWeather(for: city)
        }
    }
    
    deinit {
        autoRefreshTimer?.invalidate()
    }


}


// MARK: - TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropdownTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchedCities[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchedCities[indexPath.row]
        cityTextField.text = city
        getWeatherTapped(getWeatherButton)
    }
}
