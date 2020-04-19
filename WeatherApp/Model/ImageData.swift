//
//  ImageData.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/18/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import Foundation

// MARK: - ImageData
struct ImageData: Codable {
    let urls: Urls
    
}

// MARK: - Urls
struct Urls: Codable {
    let raw: String
}

