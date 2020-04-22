//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/21/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation

struct ForecastModel {
    
    let dt: Date
    let dtTxt: String
    
    var dayOfTheWeek: String {
        let formatter  = DateFormatter()
        let date = formatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: dt)]
        return date
    }
    
}
