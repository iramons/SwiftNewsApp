//
//  UINavigationBarExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import UIKit

extension UINavigationBar {
    
    // MARK: - Public methods

    static func customNavBarStyle(color: UIColor, largeTextFont: UIFont, smallTextFont: UIFont, isTranslucent: Bool, barTintColor: UIColor?) {
        appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                                 NSAttributedString.Key.font: largeTextFont]

        appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                            NSAttributedString.Key.font: smallTextFont]

        appearance().isTranslucent = isTranslucent

        if let barTintColor = barTintColor {
            appearance().barTintColor = barTintColor
        }
    }
}
