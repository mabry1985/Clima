//
//  ImageManager.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/18/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation

protocol ImageManagerDelegate {
    func didUpdateImage(_ imageMananger: ImageManager, _ image: ImageModel)
    func didFailWithError(_ error: Error)
}

struct ImageManager {
    
    var delegate: ImageManagerDelegate?
    
    let apiKey = ProcessInfo.processInfo.environment["UNSPLASH_ACCESS_KEY"]
    
    func fetchImage(city: String, weather: String) {
        
        let formattedCity = formatCity(city)
        let urlString = "https://api.unsplash.com/photos/random?client_id=hrOiBGmZxsMIkdw29rj6KyoA4wlOZ26OXaiXXR2Ty7E&query=\(formattedCity)-\(weather)&orientation=landscape"
        
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
                    if let imageJson = self.parseJSON(safeData) {
                        self.delegate?.didUpdateImage(self, imageJson)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ImageData.self, from: imageData)
            let url = decodedData.urls.raw
            let image = ImageModel(url: url)
            return image
        } catch {
            self.delegate?.didFailWithError(error)
            return nil
        }
            
    }
    
    func formatCity(_ city: String) -> String {
        let array = city.components(separatedBy: " ")
        let formattedCity = array.joined(separator: "-")
        return formattedCity
    }
    
}
