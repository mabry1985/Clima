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
    let imageTool = ImageUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityForm.delegate = self
        stateForm.delegate = self
        
        backgroundImageView.image = backgroundImage
        imageTool.blurImage(for: backgroundImageView)
                
    }

}

//MARK: - UITextFieldDelegate

extension SearchViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        mainViewController.updateWeatherData(city: cityForm.text!, state: stateForm.text!)
        print("\(cityForm.text!), \(stateForm.text!)")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter Required Field"
            return false
        }
    }
    
}
