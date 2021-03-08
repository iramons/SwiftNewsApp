//
//  UIImageViewExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.none),
                .cacheOriginalImage
            ])
    }
    
}
