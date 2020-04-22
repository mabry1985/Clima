//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/21/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var forecastView1: UIView!
    @IBOutlet weak var forecastView2: UIView!
    @IBOutlet weak var forecastView3: UIView!
    @IBOutlet weak var forecastView4: UIView!
    @IBOutlet weak var forecastView5: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorners()
       }
    
    func roundCorners () {
        let viewArray = [
            forecastView1,
            forecastView2,
            forecastView3,
            forecastView4,
            forecastView5,
        ]
        
        for view in viewArray {
            view?.layer.cornerRadius = 15.0
        }
    }
}

//MARK: - WeatherManagerDelegate

extension ForecastViewController: ForecastManagerDelegate {
    func didUpdateForecast(_ forecastMananger: ForecastManager, _ forecast: ForecastModel) {
        print("didUpdateForecast")
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
