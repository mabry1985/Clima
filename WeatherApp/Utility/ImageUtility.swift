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
        let darkBlur = UIBlurEffect(style: .dark)
        // 2
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = imageView.bounds
        // 3
        imageView.addSubview(blurView)
    }
}
