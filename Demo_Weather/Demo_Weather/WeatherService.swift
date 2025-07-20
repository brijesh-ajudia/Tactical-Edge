//
//  WeatherService.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation
import Alamofire

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = "f9754bfdd88615dd2c3de874bfedde26"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)"
        
        AF.request(url).validate().responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
