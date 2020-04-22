//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/20/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var cityForm: UITextField!
    @IBOutlet weak var stateForm: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var backgroundImage: UIImage!
    
    var mainViewController = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = backgroundImage
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        mainViewController.updateWeatherData(city: cityForm.text!, state: stateForm.text!)
    }
    
}
