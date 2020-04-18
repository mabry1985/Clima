//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/17/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherMananger: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?

    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        
    func fetchWeather(city: String, state: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city),\(state)&appid=\(apiKey!)&units=imperial"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(
                conditionID: id,
                cityName: name,
                temperature: temp
            )
            return weather
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
            
    }
}
