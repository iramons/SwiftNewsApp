//
//  UIViewExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(
        ofColor color: UIColor = .black,
        radius: CGFloat = 2,
        offset: CGSize = .zero,
        opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}
