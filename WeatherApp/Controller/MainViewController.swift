//
//  ViewController.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/17/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, WeatherManagerDelegate, ImageManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var weatherInfoBackground: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var imageManager = ImageManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherInfoBackground.layer.cornerRadius = 15.0
        weatherManager.delegate = self
        imageManager.delegate = self
        
        weatherManager.fetchWeather(city: "Portland", state: "Oregon")
        imageManager.fetchImage(city: "Portland", state: "Oregon", weather: "Rain")
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = "\(weather.temperatureString)°F"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didUpdateImage(_ imageMananger: ImageManager, _ image: ImageModel) {
        DispatchQueue.main.async {
            self.setImage(from: "\(image.url)?&fit=crop&h=1080&w=1920")
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
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
