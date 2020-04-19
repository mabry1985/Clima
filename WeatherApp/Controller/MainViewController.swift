//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/17/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var weatherInfoBackground: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var imageManager = ImageManager()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherInfoBackground.layer.cornerRadius = 15.0
        
        weatherManager.delegate = self
        imageManager.delegate = self
        locationManager.delegate = self
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - WeatherManagerDelegate

extension MainViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = "\(weather.temperatureString)°F"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            print("'before fetch image call'")
            self.imageManager.fetchImage(city: weather.cityName, weather: weather.description)
            print("'after fetch image call'")
        }
    }
    
}


//MARK: - ImageManagerDelegate

extension MainViewController: ImageManagerDelegate {
    func didUpdateImage(_ imageMananger: ImageManager, _ image: ImageModel) {
        DispatchQueue.main.async {
            self.setImage(from: "\(image.url)?&fit=crop&h=1080&w=1920")
        }
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.backgroundImageView.image = image
            }
        }
    }
}

//MARK: CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
