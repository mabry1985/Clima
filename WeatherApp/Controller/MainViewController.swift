//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/17/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit
 
class MainViewController: UIViewController, WeatherManagerDelegate {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
    }
    
    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        weatherManager.fetchWeather(city: "Portland", state: "Oregon")
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        print(weather.temperatureString)
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}
