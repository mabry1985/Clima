//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/17/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let description: String

    var temperatureString: String {
        String(format: "%.1f", temperature)
        
    }
    
    var conditionName: String {
        print(conditionID)
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
}
