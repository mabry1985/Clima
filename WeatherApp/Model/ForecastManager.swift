//
//  ForecastWeatherManager.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/21/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation
import CoreLocation

protocol ForecastManagerDelegate {
    func didUpdateForecast(_ forecastMananger: ForecastManager, _ forecast: ForecastModel)
    func didFailWithError(_ error: Error)
}

struct ForecastManager {
    
    var delegate: ForecastManagerDelegate?

    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        
    func fetchForecast(city: String, state: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city),\(state)&appid=\(apiKey!)&units=imperial"
        performRequest(with: urlString)
    }
    
    func fetchForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey!)&units=imperial"
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
                   
                    if let forecast = self.parseJSON(safeData) {
                        self.delegate?.didUpdateForecast(self, forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            let forecast = ForecastModel(
                dt: decodedData.list[0].dt,
                dtTxt: decodedData.list[0].dtTxt
            )
            print(forecast.dt)
            return forecast
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
            
    }
    
    
}
