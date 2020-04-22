//
//  ImageUtility.swift
//  WeatherApp
//
//  Created by Josh Mabry on 4/22/20.
//  Copyright © 2020 Josh Mabry. All rights reserved.
//

import UIKit

class ImageUtility {
    
    func blurImage(for imageView: UIImageView) {
        let lightBlur = UIBlurEffect(style: .regular)
        // 2
        let blurView = UIVisualEffectView(effect: lightBlur)
        blurView.frame = imageView.bounds
        // 3
        imageView.addSubview(blurView)
    }
}
